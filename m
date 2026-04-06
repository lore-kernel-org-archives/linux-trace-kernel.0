Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294002264A8;
	Mon,  6 Apr 2026 02:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775442188; cv=none; b=ISMWqdDN5ArWhg07Nhe1qlNU7y7MI7C1sQd58LpX6A1Hue/GafwpzVFbOZoxPwb0dtVe2Yd3MKVjQS4Ti86QbfiK+GBlkPjwgQFkcxyXNG8UZaIJDtCj/BWg4HksBLLPbJQnMPZo2zQ8aaZrOLlaaDjb1bD+Z0/XuzLYdTpdvwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775442188; c=relaxed/simple;
	bh=1yNevDOp8+FBVAjlTG16mFQyjg9HDeIngEgkljjQWcw=;
	h=From:Date:Message-ID:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J9BbDLAruNieBDeqJhPv4WVKw9NBY7U2geJOFGhLsEf0idGZunINFhUpE8MmiPVqB31uBxvP/zJEpPJNcfaYnWdvjieM8kcXLB89WI4DjV8ekbBWjR+Pec6LagbRupgshp6mMlh6VAv8cBMGpuMSs05g2/eoPsjEsZk0wQf76KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from reply.eml (unknown [111.196.245.197])
	by APP-05 (Coremail) with SMTP id zQCowADHVAgBGdNp+0unDA--.29040S2;
	Mon, 06 Apr 2026 10:22:57 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
Date: Mon, 6 Apr 2026 16:20:00 +0800
Message-ID: <20260406162000.1-tracing-probe-wording-reply-pengpeng@iscas.ac.cn>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, pengpeng@iscas.ac.cn
Subject: Re: [PATCH v2] tracing/probe: reject empty immediate strings
In-Reply-To: <20260401160315.88518-1-pengpeng@iscas.ac.cn>
References: <20260330062920.40766-1-pengpeng@iscas.ac.cn> <20260401160315.88518-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADHVAgBGdNp+0unDA--.29040S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYZ7k0a2IF6F4UM7kC6x804xWl14x267AK
	xVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
	A2jI8I6cxK62vIxIIY0VWUWVWUZwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
	84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F
	4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_
	GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
	x0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8
	JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vIr41l4c
	8EcI0Ec7CjxVAaw2AFwI0_JF0_Jw1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTR3KIt
	UUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

Hi Masami,

Thanks, you're right.

The fix is for a non-closed empty immediate string, not for an empty
immediate string in general. Your suggested subject and wording are more
accurate.

Please feel free to adjust the subject/changelog that way when applying.
If you would prefer a respin from my side, I can resend it.

Thanks,
Pengpeng


