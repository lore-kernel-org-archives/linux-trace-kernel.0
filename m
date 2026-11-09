Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.75.44.102
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794216138;
	b=uSHNYEluwNdBTTycDxnzTxi2UgYa1X2F00pJK69falmjjfpOnfEIszTk5E9P7GPu8msP
	 BLHRq1FJ7xJm3h1JuTi80xKgx+SrpY7ylBfa/DLzXsdYZM2lVEtndaY5ehtXaffiNdKuh
	 ZeLvxtgM4GkOblb0X34fGwzQwqkxCvKh2te2JSHUnd3nRkf8M9DqdGKG6nqnNnYdpc6k3
	 XD58xf3uxbLK33aiaNocbUqBKhr/MKzVEzWyRMho4SZHZ8rJb7RL2rDZ2pwGuA1D02Jdm
	 8NJVbStHz0MiJy2C9GVN/mULmOsTQ8EuRRZrezQmjDKjlKx2Wx/pwMJ4/enjKQvgvUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216138;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=hOeIq5VPY1EfMQ4JJ61ftsSvZ9lkqj4sGh1lrViA6xc=;
	b=Av1hA1RG8swkZHG0UO79Kg937hpW6kgyLucSmisqqAmCvbowcmp9qb6OiGA4ic2Ws+A4
	 HcdSv1pNfg0FgSQo5oBDfJT77HghCBHgTLjUpv9NxMEM+CJt9lTYUcUuZP6s1sr8J5lkQ
	 qe74+1mWREk5ha7QYNclOmzhkWpOqimSabXzHc0paLtLNhMEzHSMMzUCoj4XkrNa7G85j
	 VrLiDWPwRDTjEeVdetalSsiKYHTbPHKJYMrEn7jkj+SZxwMctUPBjc28s4tbVdY8Qb/s9
	 1zIwdf5CuXAMg7GNtWwimG0E7Eq1l53/qh25JBbbKvhgvheDJqoNygTI5+RB9UkrXtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=eswincomputing.com;
	spf=pass smtp.mailfrom=eswincomputing.com;
	arc=none smtp.remote-ip=13.75.44.102
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B19606A323;
	Mon,  9 Nov 2026 09:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5B19606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0002472LT.eswin.cn (unknown [10.12.96.78])
	by app1 (Coremail) with SMTP id TAJkCgCHGm+ykPFq4pqJAA--.48359S2;
	Mon, 09 Nov 2026 17:21:55 +0800 (CST)
From: Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: kprobes: decode instruction from copied opcode
Date: Mon,  9 Nov 2026 17:21:54 +0800
Message-Id: <20261109092154.703-1-yuanxiaofeng@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <20261021100058.322-1-yuanxiaofeng@eswincomputing.com>
References: <20261021100058.322-1-yuanxiaofeng@eswincomputing.com>
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
X-CM-TRANSID:TAJkCgCHGm+ykPFq4pqJAA--.48359S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYl7k0a2IF6F4UM7kC6x804xWl14x267AK
	xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
	A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j
	6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxV
	W0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAa
	Y2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4
	A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402
	YVCY1x02628vn2kIc2xKxwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4c8EcI0Ec7CjxV
	Aaw2AFwI0_GFv_Wryl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
	GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI4
	8JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4U
	MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I
	8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUznmRUUUUU
X-CM-SenderInfo: h1xd05xldrwv1qj6v25zlqu0xpsx3x1qjou0bp/1tbiAQEGE2rwpDcqUgABsl

Gentle ping. Is there anything I still need to address on this patch?
Happy to rebase onto a current linux-next if that makes it easier to apply.

