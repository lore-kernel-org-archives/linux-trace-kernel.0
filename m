Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C63F12CDA5;
	Thu, 30 Apr 2026 01:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777513220; cv=none; b=ATN0/HxxJIKx9EYzGHKhgZ8FyMRmTjn2LOutEpr3Cfb6H//DyIB22RXLQ2rKNKaE/nLfKELYb/LhjKdd60MeiaXppPEWwaW8bXdzV2ka9FqgV/Y+FeDpiBjZB2Lw+7gBYhI2wv9MoDUvnq7NSvD7mHwkXlG7QSMZYQ/XaQyIkdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777513220; c=relaxed/simple;
	bh=3gbTcurwLUfT8XK0AVhENsSu53bOSlKzUn3QQzz7yGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uYtJTwZMR3kSah6POqevtmxPD1fdadfa1JE2UbALaX/SqoVDFVEdquLJriIQCmw2K/4ux/kosopKUMD/YKHItxBtrq0yaRGGkzwl8F4kw38Aqbq5Ouay0HcZJDkoFK3JE5YKGTidS2OROmvPuEFKvhp7IxaaRN/qwwKKI4touGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=GENYwGTh; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="GENYwGTh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1777513175;
	bh=EAoIfsiAYb/EQwr5TF6KP9Q/dQr3+N+/0q2VaZW5lbY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=GENYwGThOnsWDimK+dhCtephjlm2Fx0VkZfdIklzgj4VWs+rTEpVTeVJD6n2FvDdc
	 8cNV6ZDbO0QrnMBJsfE8JVvDzI8xE6ObGHbgNK6bH3c1JywAqDc85k2jAO+gcLujj1
	 25UtSoUoBhwZIlPoW3uUykICaTJidiGpX/TdPkOs=
X-QQ-mid: zesmtpip4t1777513172tbaf71148
X-QQ-Originating-IP: cQUZHSMyWg4fHRYF1nnXDjX5ccT34B33GDFW9jY94Nc=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 30 Apr 2026 09:39:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6866613220923950043
From: Shijia Hu <hushijia1@uniontech.com>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	naveen@kernel.org,
	davem@davemloft.net,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: Remove dead child probes from aggrprobe list on module unload
Date: Thu, 30 Apr 2026 09:39:22 +0800
Message-Id: <20260430013922.322385-1-hushijia1@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260429115645.793f15ea@gandalf.local.home>
References: <20260429115645.793f15ea@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: OT1af/FwY+++W88cTSCMPjZpzVdnYtCQ6U+oNk5bZevIjsv6JG+kXV8m
	rv3yIjFkxSgvGtylNTIyYy7W/Qom8BMdw94yVeLFmA12mQqn4CUqTj0/TkSTzhVDgiGD4Ep
	UCxt7vAIaPWS7DA3iPJKBfOeIOz64+SCxuo4P2NEHqyya0C8ivYmJxPZ1QB90SKxUHcRk4b
	PdFKwJZEyuS+w422gziuzYjyrmZBSZBUZ5JutZZwtVGlyneSwkOtTnj59zPweWULuSulfgX
	Q8C1zQlK0oyr9hEm5LDZRhBs2K/Ym0bUKl1WE3dXabou+cLf2ai3hwrKRfpV3p221TLPacl
	gc8crjrqsU+C/O+3PwN0Ua2xZ8iZVVYzFn/f5celwSJ4Tg50OvK8TYLB02sRShC6QY+20s6
	ldqW0pHM5+0RpltvFV3gxTnTIVJgqWp46gnGAT9EVxAqlAQinDwBVYJhxbDdlN+m19gj996
	XAxTFCadqiCIF6Xj6mI2iKGYHV0wK8QNlfgkAaH7mrfbImVlqkm1Jtt7D30M/ja+1NlNumT
	o5uLanYeOH4wIfBgKfp6qAbi9HOtl5NKwHR88BrFBP8U0kQ81mTGlGnIfpiyrkKMFBAN94P
	ceJSzdaJcg7sIZmRYDr0137ZIq1M25MFJI2DINCNwgxMHssPt+ylv1fesgcGBEE/432PMwF
	1035+fPfu0O11MmamPCxGp8g2Vq2BnqH3hcEBZgyjF7clhzgysq6RuQsFIeXsxHq6sKhn4u
	GKyrvnLocft0og6mFSnuZHfXT4iGUZzGcRD7BVwNwHc/noyjN8Kr82R16Dr+COP12CLnpH3
	dcw0/m7/paYK/0GFIc1wjyqHFy63rCEdMZm+YlwQ/4eFJB9ifk7D6gfdy3uEogqyoOWDl+y
	l7DkY7WJnZvOOEzUHkBzbmw85U8cxXn2fFQ3AZOVBfDrKIofG0QWr+2SxisJICr5//yJ492
	aA5/EuyXu/4mpKEKBOI7Y2KMeGdOHig8zcPC5u2+qllqDZJ4Dm8FhGHqjnF+QwpjKj5CPlh
	TO4rBTTxwgk1mFvbHIeai7vjMwPtH8zFMZilCTlQ==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

On Wed, 29 Apr 2026 17:40:53 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Yes, this cause UAF because that module has a bug. Please call
> unregister_kprobe().

On Wed, 29 Apr 2026 11:56:45 -0400
Steve Rostedt <rostedt@goodmis.org> wrote:

> Yes, this is one of those...
>
>   Patient: Doctor it hurts me when I do this
>   Doctor: Then don't do that
>
> ... reports.
>
> No, the kernel isn't responsible for fixing buggy modules.

Agreed. I withdraw this patch.

Thank you both for the review.

Shijia
