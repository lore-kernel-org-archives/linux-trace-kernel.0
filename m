Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2F1264609
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jan 2026 10:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768212091; cv=none; b=NiaT4Tqhc/2tR/CNNsljb5+AR6aQK/sVcXJ/MU/6RI3fC7DUgfmR4b5zpsr0eUF39S3DS+soZpGF8GLXbuzNPFkayDxzRk7GCkEJpgXCb0m9cxaUu2WcDAgmTucN7d7swMFmqQTi43U57CYOmheNrTmcGh3MScJP0/6ufcebIog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768212091; c=relaxed/simple;
	bh=9JeFz5iGsVm/kojTUuPmUEuQUBqDoagSV+PTtqKMAaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XHnacmxs5DmuiTM56mDprv56vW1MzvXNeaeYdWxCm7NDKI7WAexvmIjLLtlbJJQ+/JcauP6g6BPNPcjeXT6AEge4TGewbNzZpjeSR42R8q92eS/8T5CHJc7GZLapV+MptpjLpqzBMzBE6QcyXWBte1pjZRLJ+iYBd38u7+p07Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RzcOSA2o; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RzcOSA2o"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768212078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kWJn/6ZZxMN6cowNKODe6mSbi42U5AhHClIhzBrc2C4=;
	b=RzcOSA2oVbhZYGN302/5p7NsRjYJ72cZLo07nmdB3pFkPfiCJLQxq5ysMaGcTGH3tpRLHn
	eQcmYrBC92/B/fVXSLgLFTAtFbrSVaOXHGNMGPXv7HXQkafr+iBBeLzxQ585FFK5ENlD8A
	0zO7wyLBPM6o7TlRca3ldLv7nPbZHuo=
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
Date: Mon, 12 Jan 2026 18:00:59 +0800
Message-Id: <20260112100059.12139-1-fushuai.wang@linux.dev>
In-Reply-To: <aWS9nOj4MAa7pYmS@google.com>
References: <aWS9nOj4MAa7pYmS@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

>> From: Fushuai Wang <wangfushuai@baidu.com>
>> 
>> Many places call copy_from_user() to copy a buffer from user space,
>> and then manually add a NULL terminator to the destination buffer,
>> e.g.:
>> 
>> 	if (copy_from_user(dest, src, len))
>> 		return -EFAULT;
>> 	dest[len] = '\0';
>> 
>> This is repetitive and error-prone. Add a copy_from_user_nul() helper to
>> simplify such patterns. It copied n bytes from user space to kernel space,
>> and NUL-terminates the destination buffer.
>> 
>> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
>
> Hmm, this function is very very similar to strncpy_from_user(). Should
> they be using that instead?
> 
> Alice

The strncpy_from_user() is for NUL-terminated strings and stops at the
first NUL in userspace. But copy_from_user_nul() always copies a fixed length
and adds a NUL at the end in kernel space, even if userspace data doesn’t
contain a NUL.

So I think they are for different cases and can’t replace each other.

---
Regards,
WANG
