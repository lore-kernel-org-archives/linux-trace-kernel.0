Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8F022EE4
	for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Mar 2025 00:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741568059; cv=none; b=H1Zpw0QYejvLENAzZGEzd1VZ8b35jXpFGNrTSUKQ86vCPb93inXnlEzNrbAWLMJKDSqISrZU3hdUqDxlSHfBu9mbozW6ORKq/bD6Wmn8rK0INYGO0yC4JSC1uwg7orQ3JBhrVwmzu7Qvv87T/lJaLbxO3R0d+JyhWJd04rfHPsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741568059; c=relaxed/simple;
	bh=iSQLpVMsIsF42btYevLSgmgUVjd7EV3WeUzrQzgqFG8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NwPEudDlSLfc4f6xbql89nMWZmZXyuo6/trE2GXmFrbUpsXYxmz7Kpah9ZypuIV88VHk5b2ku+nW2gxxL6BGqNZZb/1PKCKEAwNaXThA+1/3ZTZQaGdmIaluw1lyz1C1djs7dV9p4cwAw0MJko4UHMtxKG18Q52jTcFN2prnPkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XD9oYYf6; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XD9oYYf6"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2242aca53efso161365ad.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 09 Mar 2025 17:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741568058; x=1742172858; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5n3y6GQQXHK2s5iDRhzje5ofrtSUT2yyh7T1pq/Mk4=;
        b=XD9oYYf6rL/ejnF4c3xW8chuPnx1adKdwG6Zxp0Emvu48HdQdMGgmtxSVyV2lPb6+h
         gdZkTpdK90U/h6wqKuv+RN5jZRUamL5I+jOPT+VEzE5p/4/xYWOeAUe6M9SMmRstf8pD
         /7WxXeMwBAJ64lwaqewpw8nOwpPWrPUjnfDfWIGULEx1IuDy56LJZKqqXVeGMVdtB8Yy
         KeC6xHnZgmqUPO02/QuYO3F+g98T17r8elEdjSbgfOWwVWN468yA0nVV+NVxNG+NulrW
         e3H9hRtPmGblNEKWhM/nAqoBfw9ZXEHmGg9FyiKEM0n5B7SgPfG8nOPfOZVbbA63gQBY
         CbAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741568058; x=1742172858;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5n3y6GQQXHK2s5iDRhzje5ofrtSUT2yyh7T1pq/Mk4=;
        b=ayHM7VPyNMTM+Jfd02LOhBdjdSFIIAymlAeJ/8+ZxPWALBZdvh4BrRHS9EMh8tQuWa
         BJ0/rtQcJxhQj5FeFBlga/BSnUkM7avnpjSB2x1wf+3bv2zLdQck39rTOMJq9htpS2AA
         B7rcz174waaGj/xneRs1CSruDkxHvBjovCYwwxKeMoX3j1S+YS5o8h2bHGJ04kmfobAY
         o2jxx4m9qM8WtWf6mbVN0bDki2te3BnRQ+6pXJLL8vcJk9W/zp3owezILk+9hGkq7pDa
         PlhE6TK+kzrjuTfT3K8P78cfLm8gSOQ2XsYRD3SwhPu6uEwTHYXc08AnEBsH9ZGdcnDH
         sC2w==
X-Forwarded-Encrypted: i=1; AJvYcCVvfrMcWMJf5W4pp8S66lgNkGsrIJYC2oULDt52m81FeQEeLNQ3rXiYfbR74XdDfqPl/5ewbQv6tMtPRtBpnwJY0IA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5sj+6CqOkRS+lxUYIBn25TOuOlceL6A5Q7K1RqnCLV0HRT/pv
	SUgPSx1Fm8C2QBQXntECGN74GKFqtPhsnFhe+WmgIyh2TP26gsDqHYT0uOrLcQ==
X-Gm-Gg: ASbGncsXbPFku9jOoB3sUX5WxPM6jafsQFqqOVknaIlb6lfJYEFmJEYuEf3JcWmVGVC
	FycudXqQdzvWnR++cY4QO+w+BKMWSobH1XZA4cYosfjlNbXmo90Bctb8xm3mYqjS96M+VnX6Dgb
	OB30T2bILwDzizel0YUuz3gS3xr6fWP38OHdbpftT6V/Tet3hsdMJAmuHB83k36XXsMjsPMPPuC
	yo0RHh+Nfsrs79MbsinkZJool35EiMmPEwq2aZQ2uIh20A9j/abbc0nGQU/UcrxGFZuDxhfKr+z
	pG4WB39eIsABseJ+naG6svlF/LDx0xWcuRXhWvUc323XE3pi0rMufSrOO/5q+nu8sbm0OSXaxIN
	ywOxAjXYQrRIh9vE0puSQUJzUyaaiYlU2aBYeCls=
X-Google-Smtp-Source: AGHT+IFro0CpV48daho0xd6hGe6kreSPTXBpv7NkAJm8JjpVMpboHTVNKokQNgcCzxNaMDN6kqzbFw==
X-Received: by 2002:a17:902:e5c8:b0:21f:3e29:9cd4 with SMTP id d9443c01a7336-225416ae73cmr2795565ad.20.1741568057350;
        Sun, 09 Mar 2025 17:54:17 -0700 (PDT)
Received: from [2a00:79e0:2eb0:8:ee55:e440:a203:909f] ([2a00:79e0:2eb0:8:ee55:e440:a203:909f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109ddfc7sm65423905ad.22.2025.03.09.17.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 17:54:16 -0700 (PDT)
Date: Sun, 9 Mar 2025 17:54:16 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Martin Liu <liumartin@google.com>
cc: Steven Rostedt <rostedt@goodmis.org>, 
    Masami Hiramatsu <mhiramat@kernel.org>, 
    Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
    Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
    linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 3/3] mm/page_alloc: Add trace event for totalreserve_pages
 calculation
In-Reply-To: <20250308034606.2036033-4-liumartin@google.com>
Message-ID: <273ca5ee-c01b-83d3-6bbd-21ec4401e78b@google.com>
References: <20250308034606.2036033-1-liumartin@google.com> <20250308034606.2036033-4-liumartin@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 8 Mar 2025, Martin Liu wrote:

> This commit introduces a new trace event,
> `mm_calculate_totalreserve_pages`, which reports the new reserve value
> at the exact time when it takes effect.
> 
> The `totalreserve_pages` value represents the total amount of memory
> reserved across all zones and nodes in the system. This reserved memory
> is crucial for ensuring that critical kernel operations have access to
> sufficient memory, even under memory pressure.
> 
> By tracing the `totalreserve_pages` value, developers can gain insights
> that how the total reserved memory changes over time.
> 
> Signed-off-by: Martin Liu <liumartin@google.com>

Acked-by: David Rientjes <rientjes@google.com>
