Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8BE34845F
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jan 2026 09:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768209828; cv=none; b=q51XhdRIZc4aSxl3wmqxLyfUT1UwIaTRCjmqFcrQ7YUB0cRFIQ2YKSdflG3Nt7pyn4l7BOHutDS2f5KE6TOUYrh8qL3CDMFQ2+Tu/TEmsupc6EFrVwg5q/GHuIE/sLf8nUTluSB/Nb78R+yeuT/l2jY9uZPk/JoT/1ENxi/jQmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768209828; c=relaxed/simple;
	bh=8KdFw0MRLSjN2SSKph517IRPNaJGWIqsDCisI3qVD6M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OcJZoWSto0GwdDaveDYCU2BiUaMrX4uYOHH6U4F2v5rCKtVgWYlJxXE5NeCLp3ZODfOD/PTgqmDNKKhBPXdJddkJigss4U/DGixwkp+DTXSKjxMM3U2imiEk1PBNHRLMTnb4zEDt6E22+QW62P7UM7iFTr5nBXtkRALNTkhU6js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U2I0QO5K; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U2I0QO5K"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47777158a85so68620715e9.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jan 2026 01:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768209821; x=1768814621; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dnm1aPHgilJoZAdIhSLPs0ANyMPq33iohJKF/BMUNF0=;
        b=U2I0QO5KDme1jsJw2g/9h/GKBmPOgEo1YYDE4L/JgJ6JjhKvwZ8J72Td2h/GI/Ya/N
         kjOA6tkXvhV5KLDksOuDqLZm43s99GTUU2pK3f2cw23AgxC+tg5crFhrXQvJdMbfuVXT
         ULx8LpgUiUYNPpxSmaZzGirxgeXKhS7ZdCH3i73tUWgJlXjiT6ybg0NA2I6uAlW56LB2
         FKJHZLEbT7TFjygW58k1GZh8JKM2/tGrNCRKfBGo8lwLT6uB9bujjZZexR0jYam2N6Qy
         nKLfzqwaOIRyM4cyzY3P0wZBrtms7H9nQsnSYY4MMABH6Fd1W/dFOo1g+YNsDCdTM6Q1
         IJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768209821; x=1768814621;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dnm1aPHgilJoZAdIhSLPs0ANyMPq33iohJKF/BMUNF0=;
        b=hfbzdJxV5syhevqID5F5rEvWK55A6iVcbz2Zs0B12ZHgUY3j3ib34MCWXHI9NR0Elb
         sKYj1+4mWEwqlN1WfPufDVs/HIY1umPmZ3qPYoIQ41LcewiMkITN7RSAP+5GcliTa3SO
         twakdojbxPARjxNeEP4DHNe0bcLXpH8luagrRMAhiZu4jpWdoa8HbnjB6YYOeva37Gk0
         haQc0HEF1jnNqnFHguBFyFbK0ZqiBwJOWTxJPyk+XCdX9bTopaWMk5kpmzNs+RPTBpdG
         XvclNy1zKhlS0wHJZV4US9hvS6vHiEr+Ms0E/eQ6M+dVpsWLLfL36Ou4qP8cD79kMsmT
         Wr8g==
X-Forwarded-Encrypted: i=1; AJvYcCU3Q0ibu02+5H8UFrVVRQRC8eMBagdvxGygMBByLvsw7U8fPa7Pme6AW/3wzEmZIqBR3XPgL+9P279q/BiSLAtD+y8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMXHHbUz1HpzfiC4lryuHZ9eNmMDbhGPndbu49sbGe+9H7EuFx
	WtxjONBPAy1J0wu4gxhRxu446AqWBoL80nrDHq9N1CX1cGlJrQ1i+0CNZmknTZjEoUOmj0g6NY0
	+lMkU7pWUYzia4fh9mQ==
X-Google-Smtp-Source: AGHT+IF+IGvzp/ocb46tvnb8ue3XNMptPM6XgiWmKG8LHZGqAUCdzgBmxebkdTzyELsd/RpdGoEqlP6DpeEBX0Q=
X-Received: from wmkn12.prod.google.com ([2002:a7b:c5cc:0:b0:47b:e2d9:2e56])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3152:b0:479:1a0a:ebbe with SMTP id 5b1f17b1804b1-47d84b18db4mr198851805e9.14.1768209821309;
 Mon, 12 Jan 2026 01:23:41 -0800 (PST)
Date: Mon, 12 Jan 2026 09:23:40 +0000
In-Reply-To: <20260112073039.1185-2-fushuai.wang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260112073039.1185-1-fushuai.wang@linux.dev> <20260112073039.1185-2-fushuai.wang@linux.dev>
Message-ID: <aWS9nOj4MAa7pYmS@google.com>
Subject: Re: [PATCH v2 1/6] uaccess: Add copy_from_user_nul helper
From: Alice Ryhl <aliceryhl@google.com>
To: Fushuai Wang <fushuai.wang@linux.dev>
Cc: tglx@kernel.org, peterz@infradead.org, mathieu.desnoyers@efficios.com, 
	akpm@linux-foundation.org, yury.norov@gmail.com, vmalik@redhat.com, 
	kees@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org, 
	mingo@redhat.com, bp@alien8.de, hpa@zytor.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, brauner@kernel.org, jack@suse.cz, cyphar@cyphar.com, 
	linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-trace-kernel@vger.kernel.org, wangfushuai@baidu.com
Content-Type: text/plain; charset="utf-8"

On Mon, Jan 12, 2026 at 03:30:34PM +0800, Fushuai Wang wrote:
> From: Fushuai Wang <wangfushuai@baidu.com>
> 
> Many places call copy_from_user() to copy a buffer from user space,
> and then manually add a NULL terminator to the destination buffer,
> e.g.:
> 
> 	if (copy_from_user(dest, src, len))
> 		return -EFAULT;
> 	dest[len] = '\0';
> 
> This is repetitive and error-prone. Add a copy_from_user_nul() helper to
> simplify such patterns. It copied n bytes from user space to kernel space,
> and NUL-terminates the destination buffer.
> 
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>

Hmm, this function is very very similar to strncpy_from_user(). Should
they be using that instead?

Alice
