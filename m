Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393413B8D59
	for <linux-trace-kernel@vger.kernel.org>; Sat,  6 Dec 2025 14:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765030019; cv=none; b=hFfHO6Op4GVHnoBZf1r5Xnu6EnLNEPF/Lb6eRpL5HPO0/9Wpf64jgVLAeKWs1jUwA+0oV/pRWI3UtFcX4yhQ5I5K05Ia3e1Sq9vdIvdz1Ba8Ik9RtVa7D3Vz1D8XL2I4wLRpaQSKcjPWeLCFFPvi3Tzhx1Jx9Qn4f8hc7uDHkGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765030019; c=relaxed/simple;
	bh=vrfLk2ayZuf6l8AqfvNQb2nC/M/gETf+X2/3kIvvnp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NRXCDtSjVxwOF19n4tFUl3WOsBWJIcreOf9xTU5muntS9+Nw8h31KcBmBf1MGfJ8m1V280yb2xpQP1wi106FKIvsrJVVP06EvED7xVj5G5iOF88pAt5/JRh8RTB/17UShZKsZV8UARQUSqHdqjkLLZApoCQ1RtZHl8xSZwHEiH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZhH1t8a+; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhH1t8a+"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-78a6a7654a4so30407007b3.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 06 Dec 2025 06:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765030017; x=1765634817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrfLk2ayZuf6l8AqfvNQb2nC/M/gETf+X2/3kIvvnp0=;
        b=ZhH1t8a+DxqcJZzRWPdwIrEFa4OissoLMMeovRnYJ58RyrLlC9Lbve4Rt/ZS7Rn9LI
         9u1N6AUmAjrczf9UfFvDAbMsNIzkE4OxzNI8J18/7pI+Ujik85VPk+3tWZvUkDjC9Ike
         q2p3Y7hYGuJ79WFR5ZZ1oUx/d1i+mf68aVyWqehpNcJe5Q7SdlH5emkYYLfJNZTxiTOA
         RfKCP6xbHZAivaP3KB14PM2xZ+dgYqiK26FoinCFsLt0ej/LYS/hjLCviWkI6R2ovyIN
         LIL1+hoqNucoYTKg84CPWtu/CXeF4byErQKNUpq8ixvbE+7+/E/J/0yDHwx/UnfBjHfu
         i43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765030017; x=1765634817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vrfLk2ayZuf6l8AqfvNQb2nC/M/gETf+X2/3kIvvnp0=;
        b=Q6j7sO8KTXdXD/3u/i/OjQ87DC20C3kQ8Sv1Qx0GbVkU4KF4MuUfh86eSjG4Puyd34
         CREnOk2cOxxEtUwjjrrWihqC0jQWzLzoSMFNOE0HGVK8lsuOzD3PEutZ82x84Qp3/hQo
         8WQBQYhqHfYWFFmMSrvueqS2jfD+pe0GygdgQADB4w0W48ySsLrUX89AZNlsfZoxB924
         5NChF8ZlJMSgU1DnH5scE5UBNeXDX7vXDHt3mDDZqTMS+QkNg2kYxqSa/7ZqGVHYH2cx
         EL2CREOuZzOBxPwXyGXPHysKuy9+omtejOQ0V1ptEFedQLWcZD5b7X0f+4QJrUP4PkaQ
         bq8w==
X-Forwarded-Encrypted: i=1; AJvYcCWGtLfrG1ef9ktwN0BzquKW/OZ1pFBVLPmh4DIFXCdOrTZbrVILLULFZwfENefDu/0/o6LtDok3z8DS+wEUKmU765s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuyPU9o6khbQD7H3C9ullwLc9UVtGn0ynqRC6Fo7HXzNnQHGzf
	/6WtFdM/SNC6Lmu7Ti1jLLwnMWNEUz6L4R1omggWHuNi0xonCL6RlOkt
X-Gm-Gg: ASbGncv6ARC50IO4t2la6aQJK4gHJOt2Wn2EYovihs8mE1U6Lyy8LbGtTfesV7qXFmn
	1e67pARDnsw/Zlm5IWUqKjepxbwl+VOOyp+SRtFT2E+tbgwPfAq1M8DIuwWGUKEOv5q9urw8A/M
	zgS6T0u5WtH/vmvZbkXY/gRQ8XXzX8xOHEdkZv4kJ6XlAhGCsyn9+TJB2AhsGeRPUbEPgl+S7OV
	khbc9ji7gPyyX72Ap1u5tgp7k6bTUCce9h9wXC5Oie8iNuFloQfBA/uRB/dPPHSWp5uOFNlg7Ez
	mFDF+3JaYVQ66uD8WFzJndt+ejf5HOp8K/L6sEEnZKe0IYOUPkFpzSPnegAaVGQyRxjMRhhJ2i/
	17zhz9pna4lVQC3fpFYT9/7Obn84YQzXUcvOzfGxAtTdYJ7d6J9Gt2E47tiiYHzziZ6+0t/8IAi
	UDM60zJzljHwo2Dr2og3sccgnuSYbMcEmfUkOI/8SZQCRGnSAkEOM=
X-Google-Smtp-Source: AGHT+IFxy8fT1dRrg4d0q8df8JdyXkj7/oD1PKfr96MRoX5/mmgZfjfDMVE7BSdSSFxAui9wnKIK0w==
X-Received: by 2002:a05:690c:7403:b0:788:1cde:cac9 with SMTP id 00721157ae682-78c33b5f13amr19558807b3.23.1765030016967;
        Sat, 06 Dec 2025 06:06:56 -0800 (PST)
Received: from localhost.localdomain (45.62.117.175.16clouds.com. [45.62.117.175])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78c1b79942dsm27541147b3.49.2025.12.06.06.06.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 06 Dec 2025 06:06:56 -0800 (PST)
From: Shuran Liu <electronlsr@gmail.com>
To: song@kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	dxu@dxuuu.xyz,
	eddyz87@gmail.com,
	electronlsr@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	mathieu.desnoyers@efficios.com,
	mattbobrowski@google.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	sdf@fomichev.me,
	shuah@kernel.org,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf v4 2/2] selftests/bpf: add regression test for bpf_d_path()
Date: Sat,  6 Dec 2025 22:06:40 +0800
Message-ID: <20251206140640.3013-1-electronlsr@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAPhsuW7NTGkbVD97DQddwPEQR6PZgYQJ6c-JcEsNUg6ddnh3rA@mail.gmail.com>
References: <CAPhsuW7NTGkbVD97DQddwPEQR6PZgYQJ6c-JcEsNUg6ddnh3rA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Song,

I have done further testing and found that the initial version of
selftest (LSM version) could not reliably reproduce the issue on a
buggy kernel. I have now verified that the new fallocate test
correctly reproduces the bug.

I will be sending the v5 patch shortly. (This is our first patch
submission to the kernel, thank you for your patience :D )

Best regards,
Shuran Liu
