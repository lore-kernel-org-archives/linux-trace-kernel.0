Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3183A320A0F
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jan 2026 12:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768220584; cv=none; b=tfKRdL3+3aJb2Imp7zNBOq4k8NZjdGslhdHl5p7qKnfjTBWMnbgGFEQQklPVJY/uX7RyUmGQMn/qKPr4wyHkhFBWs64uqDLPHr0yiuehfrJNOHp4mwYqafCEmBqG/CsYznVxKmljZtX6ErNQiYwx/4TNHexNs7FX0+KTCFPkyOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768220584; c=relaxed/simple;
	bh=D+bJUDQC3UuQUMyyxI8OJgsbzeRSgQzkhMRFK279WZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f6aQXNJpuuhwTrJkf752/N79gmSkN1D7LdV6STW+Bt1ZDtoXOCCZRKLfBr2XNSPCm96Yobja+DccG0wfg4rYY8nS4FJaqC+FmE/i+GysOpPFbcKJZYEg2vV5kvmjrgxGXCYYL3fA98E4wI6G8U8tupEunzqRvmaPj6lTveQmUEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xCQyv4+V; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xCQyv4+V"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768220581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8lx/Tv0eHh0jnDPeU3CCDrjYVz6Oe5VZ0Zr51tRiY7s=;
	b=xCQyv4+V4VSQrEhdEgciL+sjEfXXMe4OHLh/WqwKfZP4mN2zaiI64U4ZrtK8z2U7suHA6L
	GXR4MnNp2S4picLYKrszdLT4uhTs9l1qjhMLwgftH9mcIWTdbXsngTky0k5//19CsAzuBo
	pFhk8VYi7CxJOsLpN7m0ZG+Cy9XTkl0=
From: Fushuai Wang <fushuai.wang@linux.dev>
To: aliceryhl@google.com
Cc: akpm@linux-foundation.org,
	bp@alien8.de,
	brauner@kernel.org,
	cyphar@cyphar.com,
	dave.hansen@linux.intel.com,
	fushuai.wang@linux.dev,
	hpa@zytor.com,
	jack@suse.cz,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	luto@kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	tglx@kernel.org,
	vmalik@redhat.com,
	wangfushuai@baidu.com,
	x86@kernel.org,
	yury.norov@gmail.com
Subject: Re: [PATCH v2 1/6] uaccess: Add copy_from_user_nul helper
Date: Mon, 12 Jan 2026 20:22:36 +0800
Message-Id: <20260112122236.22214-1-fushuai.wang@linux.dev>
In-Reply-To: <CAH5fLgiPdBEN7mjgK64u19VGE_AWghTnCCHYuQQuwnTdvDaYkw@mail.gmail.com>
References: <CAH5fLgiPdBEN7mjgK64u19VGE_AWghTnCCHYuQQuwnTdvDaYkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

> strncpy_from_user() succeeds even if userspace data does not contain a
> nul. Then it reads length bytes.

Yes, but if there is no NUL byte in the user buf, whether you use
strncpy_from_user() or copy_from_user(), you need to manually add
a '\0' in the kernel buf to ensure it is properly NUL-terminated.
like:

	ret = strncpy_from_user(&buffer[0], arg, sizeof(buffer) - 1);
	if (ret < 0) {
		ret = -EFAULT;
		break;
	}
	buffer[sizeof(buffer) - 1] = '\0';

So I do not think copy_from_user() + '\0' can be instead of strncpy_from_user().
I think strncpy_from_user() can only be used without manually appending '\0'
if someone are certain that the user buf contains a NUL byte.

---
Regards,
WANG

> As far as I can tell, when a nul byte is present, none of these kernel
> use-cases use data after the nul byte. So the behavior is identical
> except that copy_from_user_nul() may result in EFAULT if there are
> unmapped bytes between the first nul byte in `src` and `src+len`.
> 
> Alice

