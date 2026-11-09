Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.101.248.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794216184;
	b=D3EXUFsbWiJXXnvg/vnoeT0RW9sKCBvmiur1R5Nub2gCnU6xjs4AGVYovyTeVDMAvZXy
	 KFu+qTfWqbovifiiAFCJcoo1W4/Y4lekYUHZdVepmC1xUQc2dWVsSELjvJb9CP8mxr8kb
	 9D/F//f7gnOFvvAtMbzB5hKVxK2C20w1zP26GnIuKjW+h4DzDJJiee6gVJ2S6d/g+/zR3
	 sZ7vjmv7pKN9pWYRcOGtOybbMvM9Ak8XsZVUgt6KsY5hXD1Oxp0qV0ojcNrWh1JrnuUvP
	 i9WRVkC/AiLD3oDZElEHJ5TfNRF22xvxuUHKbPx5wecmTQ1INXQD3EulpYHy+momw3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216184;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=bqG5W44C29mMzUssQf1PedJ0gjOEMrBFRNaleKCf07E=;
	b=mH+UxFvppvj8ptxr36G6wAImObk6/yfrNX7yB0mnBGxdeCsje5R0I6fRkp+03blqI5iH
	 gp1WKTHqjxvEioJAKONyiJ/ZqHGXYqq49Pb6ezVdbVTPIFZu7vSUUa4IniccdyNWqtAUl
	 rydzylV7ANYcsxg/meJSGnSMs7GAoyqZ0D+654Sl2wUaMf/rxKgvUAgDkbugn/2w2qB+H
	 GZ3MOGezzr6Dk2TPK61GenIdt0inTpsc2c4PgZB1pgQSp7r5LUiy7DdxdOkHbpNgW9eN1
	 elBAeEoHvkPtWpT6w636rWlDySrnJQ9tXBOZlfuGFnTi4eyGs1R3+NY8VSLBTvSVtBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=eswincomputing.com;
	spf=pass smtp.mailfrom=eswincomputing.com;
	arc=none smtp.remote-ip=46.101.248.176
Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA0A6082BC0;
	Mon,  9 Nov 2026 09:23:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFA0A6082BC0
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0002472LT.eswin.cn (unknown [10.12.96.78])
	by app1 (Coremail) with SMTP id TAJkCgDHWW7jkPFq6pqJAA--.47946S2;
	Mon, 09 Nov 2026 17:22:44 +0800 (CST)
From: Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>
To: Nam Cao <namcao@linutronix.de>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] riscv: kprobes: simulate nop and c.nop instructions
Date: Mon,  9 Nov 2026 17:22:42 +0800
Message-Id: <20261109092242.810-1-yuanxiaofeng@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <20261020064136.665-1-yuanxiaofeng@eswincomputing.com>
References: <20261020064136.665-1-yuanxiaofeng@eswincomputing.com>
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
X-CM-TRANSID:TAJkCgDHWW7jkPFq6pqJAA--.47946S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY37k0a2IF6F4UM7kC6x804xWl14x267AK
	xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
	A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j
	6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxV
	W0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAa
	Y2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4
	A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Av
	z4vE-syl42xK82IYc2Ij64vIr41l4c8EcI0Ec7CjxVAaw2AFwI0_GFv_Wryl4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxU7-B_UUUUU
X-CM-SenderInfo: h1xd05xldrwv1qj6v25zlqu0xpsx3x1qjou0bp/1tbiAgEGE2rwpK0rJAABsL

Gentle ping. Is there anything I still need to address on this series?
Happy to rebase onto a current linux-next if that makes it easier to apply.

