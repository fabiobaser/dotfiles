import React from "react";

const useState = () => ["", console.log];
function Component() {
    const num = 123;
    const [name, setName] = useState<string>("React");
    const a = name && "123";

    return (
        <h1>
            <span>owf</span>
        </h1>
    );
}
