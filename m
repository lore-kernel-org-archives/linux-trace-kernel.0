Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.75.44.102
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794216143;
	b=epMhqf9sNgt5hJ+kDLXH8EE3lDzW7JG1Wx+RdUPVF4omYZbUksRMI4Wn0mijGtSSk62E
	 W+TYifOcjx64pz9/wAv+1hTWQOCcIluO98SPVFjcKD2UkubxWvSSKt5FcNNot6OsQNNu0
	 k5s/Y2h+V2LD5gFjmjE6PTtNw4HFXx3lIAYEQPpuHP4/9thlDEPVy4I/L2p8xzzhzIKy3
	 8uwuYBjqpeoB/WJwtrcv+2A3RgyfdHWSgUw7KUQXTZUirC7/dmROuq/Q5xM4pzO0iy2Fi
	 h0AlO8h5lyUISC/vWZeF7Ftnv8ECYEaEXmqio10eUdCbgj/ePbF3kFbrxZECSNedK+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216143;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=bqG5W44C29mMzUssQf1PedJ0gjOEMrBFRNaleKCf07E=;
	b=5A/6MspK4Tk+WJWzw4JL14eSYaQKaJYyX30roRwtbX3uJlOetWbioZ5wzCSGUW1vtVBt
	 9GVhsOCycE+laErCu2q6Dk7Z8byHg7an4Ehs8OHcaNjc8EZQ4a5fy1vO1bXwf09j7CfWl
	 XeUJaubMmeHX2bOd0q6KKmZE0j/901zrtbXaTbkdLOVs2SBQMfxcR15E2rnZU0Xqonbqk
	 BkYrQPfWQQuJOqVZnLURQjmN8E7dYNdX6NutNRGZ1rMdOEKabsfuCeThau2nYXi/Mg6IT
	 EG+lDJU9z8A3DsPDBZCmr19m9u8fCQuPqjkm677JuEv39Nag/tjAfPPGGTZ5jyMvrBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=eswincomputing.com;
	spf=pass smtp.mailfrom=eswincomputing.com;
	arc=none smtp.remote-ip=13.75.44.102
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7888606D805;
	Mon,  9 Nov 2026 09:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7888606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0002472LT.eswin.cn (unknown [10.12.96.78])
	by app1 (Coremail) with SMTP id TAJkCgBH2W3CkPFq5JqJAA--.47473S2;
	Mon, 09 Nov 2026 17:22:11 +0800 (CST)
From: Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	Nam Cao <namcao@linutronix.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/2] riscv: kprobes: reject probes inside LR/SC sequences
Date: Mon,  9 Nov 2026 17:22:09 +0800
Message-Id: <20261109092209.756-1-yuanxiaofeng@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <20261019134121.1763-1-yuanxiaofeng@eswincomputing.com>
References: <20261019134121.1763-1-yuanxiaofeng@eswincomputing.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgBH2W3CkPFq5JqJAA--.47473S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY37k0a2IF6F4UM7kC6x804xWl14x267AK
	xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
	A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j
	6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxV
	W0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAa
	Y2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4
	A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Av
	z4vE-syl42xK82IYc2Ij64vIr41l4c8EcI0Ec7CjxVAaw2AFwI0_Jw0_GFyl4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxU7-B_UUUUU
X-CM-SenderInfo: h1xd05xldrwv1qj6v25zlqu0xpsx3x1qjou0bp/1tbiAgEGE2rwpK0rJAAAsK

Gentle ping. Is there anything I still need to address on this series?
Happy to rebase onto a current linux-next if that makes it easier to apply.

