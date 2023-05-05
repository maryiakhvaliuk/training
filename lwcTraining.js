import { LightningElement, track } from 'lwc';

export default class LWCtraining extends LightningElement {
    @track name = 'John Doe';
    @track email = 'john.doe@example.com';
    @track phone = '555-1234';
    @track orders = [
        { id: 1, name: 'Order 1', amount: '$10.00' },
        { id: 2, name: 'Order 2', amount: '$20.00' },
        { id: 3, name: 'Order 3', amount: '$30.00' },
    ];

    handleSectionToggle(event) {
        const sectionName = event.detail.openSections[0];
        console.log('Section toggled: ' + sectionName);
    }

    changeName() {
        this.name = 'Jane Doe';
    }

    changeEmail() {
        this.email = 'jane.doe@example.com';
    }

    changePhone() {
        this.phone = '555-5678';
    }

    resetSettings() {
        this.name = 'John Doe';
        this.email = 'john.doe@example.com';
        this.phone = '555-1234';
    }
}
