Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959E027587D;
	Fri, 17 Apr 2026 03:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776395218; cv=none; b=fPo5Y2uR9vPtgMQp60cMJEkrw9n3EGW8rVMGAkvlCihAnEPtRunaN0M6WlRK0nwmxxke2y6YaC2BtBPWNmBjV5UcMlF++/tSoiGLU/NcHF8VIT9W2Vjk175i621jpw8XDqyIbWv1H+fbDYKNpMAEYPDP8S0YQIXPl2JiCi5vayI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776395218; c=relaxed/simple;
	bh=HwHwN9i5Xsc5A2x0uOsi1cHRIS/BRVGr1semr8PTiGo=;
	h=From:Date:Message-ID:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p7e0omMAT5nPQW5HWtpECxgq998F0Pb31wxVgI8O6h+p9Z7GMokdSt6Q0rLuPVlsuN+lyUBZcgmAWll1u23ZSYP5cXxCZJWYiyISd1gmkbnfyTwKnorB1Ehi1Eq5CdT8Jb27Yu3NYQRRumU8zfVXWdvZ57dwQIkBrKBqIge9HZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from 0001-tracing-hist-synth-reply.eml (unknown [111.196.245.116])
	by APP-03 (Coremail) with SMTP id rQCowACHnNO_o+FpCrhVDg--.50364S2;
	Fri, 17 Apr 2026 11:06:40 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
Date: Fri, 17 Apr 2026 11:06:39 +0800
Message-ID: <20260417190001.1-tracing-hist-synth-reply-pengpeng@iscas.ac.cn>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Tom Zanussi <tom.zanussi@linux.intel.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, pengpeng@iscas.ac.cn
Subject: Re: [PATCH v3] tracing/hist: bound synthetic-field strings with seq_buf
In-Reply-To: <20260409103001.1-tracing-hist-synth-v3-pengpeng@iscas.ac.cn>
References: <20260329030950.32503-2-pengpeng@iscas.ac.cn> <20260401112224.85582-2-pengpeng@iscas.ac.cn> <20260409103001.1-tracing-hist-synth-v3-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACHnNO_o+FpCrhVDg--.50364S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY77AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87
	Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAK
	zVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx
	8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF
	04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AKxVWUAVWUtwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

Hi Steve,

Thanks, I'll respin this.

I'll resend this with the tracing-style subject, add the clarifying
comment for `seq_buf_str()`, keep the `event_var` simplification out of
this patch, and move `saved_filter` back next to its point of use in
`create_field_var_hist()`.

Thanks,
Pengpeng


