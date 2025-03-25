Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7A31F5617
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Mar 2025 09:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742896007; cv=none; b=qIGcH6tRXDHTG0sgSeny/0NOl6A/n3U2E+hekCMA1ffytGYPDZxxdC8SsPPqPXOAZ7lNzrRtDO/DCdCGs9jXH9SLkbQHJJxAA008cleAJyF6M6GocQIGHC6BxBae/ZQR6a20qclBEs+uCkGidkM84Sg+kfpk2vZo6YishmuZ/3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742896007; c=relaxed/simple;
	bh=GjiEbFoY/UGEFhuXgO4Md7Z3mYQ2MwEfWlLsdmw7Djs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cvDqYGRO3zySKsDoQHN7V6WwcqR3RqQZnJY2SCImtuDPzLc0nScmDeYzcqZnKmmxsU95+6gfySBXWFMB4Eg1SFqz0TlQ3opkpdKZNuPTD5uTCWtVqHNgMHZyHicHUn+nb+rxXyiRo78QZIs6Y8lwl8DrJRXa3Yj/zjpw4uQ0B5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IzuE9DBj; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IzuE9DBj"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-523f19d39d3so2578598e0c.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Mar 2025 02:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742896005; x=1743500805; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b2lX5tfn7tIpxTTiRAKwTMrvBSHE/QiBFZ33eS8Haa8=;
        b=IzuE9DBjsaK7i0FVTeTco33PyMaRUhGg6jiRpeJnywHlXM0QEHN7gdCOQS99uFb6yH
         V1Bzig90qRFLv3Xn6aJrOaM7nK/e9sXIhnSXYRpyRyCp9WBq2J9kyIATYAwS/bODK0Q1
         fJJaLdLwYtmWsloYIF5ccKZYt5Ee328qlEKpfH4rFgjhqgUY461VgQuzf+9cCpCvMnZC
         FeMofV9GRQ/Gvr5lzfPjGdMym9olp+hdxGM8EywFNeevRUKmQDGq0oJH7GsbpR8zorxB
         DS39/Iyxa/vtDKvCZf7sTxr1xBUX6dTqIccjd5ehRryD0i+xviBH1dAu5dL02m2dv7zp
         tRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742896005; x=1743500805;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b2lX5tfn7tIpxTTiRAKwTMrvBSHE/QiBFZ33eS8Haa8=;
        b=sGsBnuSrsKDy6FKeQuaJxInzEs2cn06sovSiWaLB1P0s8ozw2Clb6GP/hVSbqk3nTt
         Gmo0X513TnQp4PuhCO6zMogFXiqMVloe67rPkRz93e0ZtbjPpZPQ+cOKs6vieODM/yxC
         AcDRqVu5XGWvgWdub9TK3bE9uxJCOMVI/OtqJ0EJfL32Bm9mwpiSaiNDLKoyPesmngdh
         ACfqUtYbIm5U05SYSRD/Ortc7IT4J8lOXHfu7EYwAWN+h3RpQV0F/drI/2OPPNmfgP4B
         SLiHavEDQvikPKq3E+XBZehu7ndwj44uDZfvsm27c9329jlJwTjWNB8yK/kGwS2ODP/Y
         M1Yg==
X-Forwarded-Encrypted: i=1; AJvYcCX756Igt+mIBhPCUrgSV9WVobluuoTDckNPBJdkm4cDeb6UDGp406T+OtEFac6dDTmxwYY2BBflPknW24nYtNE5ZGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwljKnyQWN98B17WacXMhn2ISgfursan09Wx8t0nFXUXZcWemOj
	ItBr2Lc6BIjfIpdv512xEHZI69596X/K/bY6QquFfri0lAh9wP2G+t+BMNY79H99HDNL7amhKwP
	hw6iYdG+DeJCChbEGC3LHRjdCsAfcl/OyJKSUdA==
X-Gm-Gg: ASbGncunbGjbM2AFSZjVANtJ/WN0wR+KTeqaapAFjZCWupKpO8skv8it9TSA8OPy/cl
	jA3LAi376LPF4YmzTTYrL3aZFmKkQ0pgC96L3tBG02FR3bOhpbEiQJB/szEnRJZQOy0/QVKrjHw
	2n3tSxuaMMEzZHMjg6jOFERfTva6vH/3EP+szc7FNWANcZgNOw6kitq1r5e0A=
X-Google-Smtp-Source: AGHT+IH//1u3lm0gEX6665f+nDZ4nWHXHyc8at04VLjpmQ8T0A2klnwJ74tyli52akhfB8SGxJAMgSoflf1CfRHTSfc=
X-Received: by 2002:a05:6102:3e8b:b0:4c1:9159:859c with SMTP id
 ada2fe7eead31-4c50d51d56amr10977038137.15.1742896004860; Tue, 25 Mar 2025
 02:46:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYs62qxt1PajEp2A8uUmQFeAsC2JBV2wuspbAxz_hFF7CA@mail.gmail.com>
 <CA+G9fYu54p6zQpX3Kw4dy+Yy3BM66r_iawvLchPvsB_Sq_wCNQ@mail.gmail.com> <20250324103313.2bc42730@gandalf.local.home>
In-Reply-To: <20250324103313.2bc42730@gandalf.local.home>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 25 Mar 2025 15:16:32 +0530
X-Gm-Features: AQ5f1Jr22uNyEeSzPJIeFAGaU0oB0Z0_gFBkxqProEQ282Ldn9GhG4OhHPUzA3k
Message-ID: <CA+G9fYuFNCoSvZMYYpqMT1SC-p2W9Ra1EuwV6p2kiOH61Uxecg@mail.gmail.com>
Subject: Re: next-20250319: arm shmobile_defconfig trace.c undefined type
 'struct module'
To: Steven Rostedt <rostedt@goodmis.org>
Cc: open list <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Mar 2025 at 20:02, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 19 Mar 2025 19:42:42 +0530
> Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> > On Wed, 19 Mar 2025 at 17:01, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > >
> > > Regressions on arm the shmobile_defconfig builds failed with clang-20 and gcc-13
> > >
> > > First seen on the next-20250312
> > >  Good: next-20250311
> > >  Bad:  next-20250312 .. next-20250319
> > >
> > > Regressions found on arm:
> > >  - gcc-13-shmobile_defconfig
> > >  - gcc-8-shmobile_defconfig
> > >  - clang-20-shmobile_defconfig
> > >
> > > Regression Analysis:
> > >  - New regression? Yes
> > >  - Reproducible? Yes
> > >
> > > Build regression: arm shmobile_defconfig trace.c undefined type 'struct module'
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > Anders bisected this build regression to the following commit,
> >
> > # first bad commit:
> >    [dca91c1c54686914dec4dabea8bae4f365c02007]
> >    tracing: Have persistent trace instances save module addresses
> >
> > Lore link,
> >  - https://lore.kernel.org/all/CA+G9fYs62qxt1PajEp2A8uUmQFeAsC2JBV2wuspbAxz_hFF7CA@mail.gmail.com/
>
> The fix should have been pushed to linux-next already.
>
> Could you test the latest linux-next?

The reported issue is fixed on tag: next-20250324.
Please refer below link for more details,

Link:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250324/testrun/27735288/suite/build/test/gcc-13-shmobile_defconfig/history/

- Naresh
