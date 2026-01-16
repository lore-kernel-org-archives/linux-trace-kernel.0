Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B4D3090CD
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Jan 2026 08:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768553000; cv=none; b=eXq0vjH5Oj+hF7121IkKqTB6xLcaXdFOqWLU2/o67hcJ4Dfan6Rb57N3plmiFgYTBja7yR9bUzOxRy3PtVhdV3HsxUcB9PtONxjfVi6bjSUQzG8FW2tyjMBTp3gOwYc3/u1Y8B3dyZTOA7ik2fv1gi8lm8qnShjz5cNmsNLsC0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768553000; c=relaxed/simple;
	bh=ZkAfuyZif9Knvhbi8VFzVhNSGj/1AHh3HsMrtbbFPWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FrWcd28E/xhiDFx26/88NugmEub3sLTmRO5AJPoUAGL3uq/FFbjItCvURyrJnymdLP6iiPg2fh6LBP6nkWW4Ogb61KTUFc4ofqiy0RUK9cgwtuX+xvUELekZij1nmwe9DlYOl2/Nvb6gfKLc31CpgPvmr6+hEo2iEc0D8XyXweg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lY0itTuG; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lY0itTuG"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768552986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6VF7hcDg+1fL1q75GHBxhfMy9OtqdkCw+45PGJdphbg=;
	b=lY0itTuGxgDMzP3SHarU/Nun2mkaU+93bFA5R9CgdBvOCjELF9G/hSERttJ/tpXMJzD6vC
	1q4O0n+xlCZ9HKhjjNnnP5GOJGDWhvwh5SUugnLgg81kJHQmASI7jCktmgtv3HW6Jag+Jx
	bWTF8a5UG5FovolSTVT0vvOPMzNoHNU=
From: Fushuai Wang <fushuai.wang@linux.dev>
To: ynorov@nvidia.com
Cc: akpm@linux-foundation.org,
	aliceryhl@google.com,
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
Date: Fri, 16 Jan 2026 16:42:47 +0800
Message-Id: <20260116084247.26024-1-fushuai.wang@linux.dev>
In-Reply-To: <aWaIOT_o-99G-_r-@yury>
References: <aWaIOT_o-99G-_r-@yury>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

> I checked the cases you've found, and all them clearly abuse
> copy_from_user(). For example, #2 in tlbflush_write_file():
> 
>         if (copy_from_user(buf, user_buf, len))
>                 return -EFAULT;
> 
>         buf[len] = '\0';
>         if (kstrtoint(buf, 0, &ceiling))
>                 return -EINVAL;
> 
> should be:
>         
>         len = strncpy_from_user(buf, user_buf, len);
>         if (len < 0)
>                 return len;
> 
>         ret = kstrtoint(buf, 0, &ceiling);
>         if (ret)
>                 return ret;
> 
> See, if you use the right API, you don't need this weird
> copy_from_user_nul(). Also notice how nice the original version hides
> possible ERANGE in kstrtoint().
> 
> Patches #3-5 in the series again copy strings with raw non-string API,
> so should be converted to some flavor of strcpy().
> 
> #6 patches lib/kstrtox, which makes little sense because the whole
> purpose of that library is to handle raw pieces of memory as valid
> C strings. One would expect such patterns in library code, and I'd
> prefer having them explicit.
> 
> I find copy_{from,to}_user_nul() useful for objects that must be
> null-terminated, and may have \0 somewhere in the middle. Those are
> not C strings. I suspect this isn't a popular format across the kernel. 
> 
> On the other hand, adding the _nul() version of copy_from_user() would
> make an API abuse like above simpler, which is a bad thing.
> 
> Can you drop copy_from_user_nul() and submit a series that switches
> string manipulations to the dedicated string functions?

OK, I find some misuse of strncpy_from_user() + kstrtoXXX(). I will fix
them.

Regarding patches #3-5, as Steven mentioned, I believe we might need a
strscpy_from_user() for these cases that copy a non-NUL-terminated string
from userspace?

---
Regards,
WANG

> Thanks,
> Yury
