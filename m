Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615E9212D7C
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Jun 2025 12:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750163479; cv=none; b=drBzoWtpyd6l0mSKBtW5O2/qZx/wXBFxRnjKmGLiPQyjrqXgmiwBG6fxiVVPobIYwNXYbomOurY82g3VueA1RmGsaqszr68olLw5vsDmdfDG6UkIl+K3U8RcZO31NMHGlP7LbOenEfrYZ5FAZUmzV9J71dbbxbiDKfQu29iBzMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750163479; c=relaxed/simple;
	bh=+uZWDZy9xuYrsdwKUlxju0n0w0AKCo6XtJq5+cSCxW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fMVFZufmWRFERToo7cZx2Fy/zPBJvx9swdgTz3EsMBgbVCHudq7pkBMmLuchwz58rqaIH546HF7Fab3087jTGtO8k67cWNmzkkuhQL1jrKAI/Ninq+V5NG7suD1dNG3Wcm+IKVb4uhivpvPNNH7pXWX1NC4HegZa8Zj2SYxpx7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zFrSc1YN; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zFrSc1YN"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-53145c74e15so1043470e0c.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Jun 2025 05:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750163477; x=1750768277; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+uZWDZy9xuYrsdwKUlxju0n0w0AKCo6XtJq5+cSCxW0=;
        b=zFrSc1YNRGBtR/+Y+DJkaGURtEdEORjQuztfZLbYSjfCDU7UI02oSFZH5b+5Qy10py
         Zi3O1g1WQYVxrv7E/h6KlemWVAoHGEGyjXeE+JWWsvVSJZEZLHATv7UQ2W0m5n0U8lD7
         XOYu3z0iNCm2E0e6AYzeqLiITiXrTwdtiTnxAMBejs5/cIdS2hGOx8eCmsCTleJYMYZ9
         vSerqidLN8I8rGVg5YLnmExDi6m0UinSJxZF3QPMItLQyL4r5xnls5UcvLecmzpWu3h/
         GN6hY/IL8+uJaN8+ZTX9c24RvY119d+OLqen2N4ASMILmf5bG0Oc5E2zuN/8pRWP5mTb
         RDdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750163477; x=1750768277;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+uZWDZy9xuYrsdwKUlxju0n0w0AKCo6XtJq5+cSCxW0=;
        b=ErZzAbN5oyvzzxyu9DY5YWtFoGUoYQC/g61+kWhbdXDuWGCjcjN7DNsoDuDw5IKDHO
         tilx64DP84uA8touoW3b0c0/KOv5OzPgAkT6V9m/f6sAd6Y0/KelLJdKeX8pJthd/IiN
         o4LkewQy61HNsx8VFGtrJx+2EwNcwBUS4PeKwMzB1+u1X+M91RdCTphpI8w8+4+imGbE
         7EbM5VK68RD7XyE9UJLyFT2bR1BaiitALtXEdZy9Yv0bWupCbjNhiLeXzplqSybfSNMI
         XfTBAy1DMavgBeqEp3iELWweZIy07gJlZHe5wJKU6owvk1jXN28H7AuU/dF3tgqqBQB4
         T7dg==
X-Forwarded-Encrypted: i=1; AJvYcCVMyQ7KNc86+/Fs51yXl9wt7fY3/7TQHSe4AhLqFIndJ6/wJxxWJ8Mg+L+cWwe0UkFYfN8QgZzNeqiG48qdR8+fbSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZx1wrv8v8dSt9tRp5m1su0t6h8k3YGDX1FIjZMEMcCaSKx949
	jNwW39eePCbHD8FVbazjXDOh44DPjWuJslzyQMZjeN6/nU0G641bYpSodnGM7omC9er3ZV06plF
	iJlIAg8TOSPMvIvPNlgEePOKN3dTI1r+wEyWrgpjATA==
X-Gm-Gg: ASbGncuVkAcShzbSS0ebjyNcvptKzdy83ogYaqaxHJ8m7KpUP0bO1NosdpZ6rWe39Cc
	D4yvn5/TBf1s8xEZEnOs3zQ25nihYt1S3OiRdBIBfI9Gdvv8zDrp0USPCiGbMQllV+gchnYjZgS
	UXlfWrz1TThMUAHyglxY9u/ynxPmuHrUKhIheWai6t67PtIw/merT3hworIHWqQYckk7jq1TPj7
	ih4
X-Google-Smtp-Source: AGHT+IHI6oUlH5le8/OtMwtl++u2ijNoxmk+ioHAnyJhKHp6pNKG3NNl2OPoTIdi6yloM5vSnSDZbuh68sxd1gcl+YE=
X-Received: by 2002:a05:6122:2789:b0:531:45f1:604d with SMTP id
 71dfb90a1353d-53149816854mr7875030e0c.6.1750163477167; Tue, 17 Jun 2025
 05:31:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYsLu0roY3DV=tKyqP7FEKbOEETRvTDhnpPxJGbA=Cg+4w@mail.gmail.com>
 <20250609220934.2c3ed98ba8c624fc7cb45172@kernel.org> <CA+G9fYsoCc3DnNGoavFiBdymVpdJiEfUSEq967GgThVQW7bTPA@mail.gmail.com>
 <20250610105337.68df01f4@gandalf.local.home> <CA+G9fYv+1FPMD8e1ZadA3nLcfSRDAWvPRW-A3bGrV0y1VP2zLQ@mail.gmail.com>
 <20250613172753.3479f786d40c29ec7b51df0a@kernel.org> <20250616163659.d372cf60ee0c476168cd448e@kernel.org>
 <20250617194159.d74b9cde9268ee8ace8e9018@kernel.org> <CA+G9fYtuiFHYBuRpB5MVwnZqc+WVRnnYMRHUExXAyu3_jMVurQ@mail.gmail.com>
 <20250617082544.24b54ad2@gandalf.local.home>
In-Reply-To: <20250617082544.24b54ad2@gandalf.local.home>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 17 Jun 2025 18:01:04 +0530
X-Gm-Features: Ac12FXxCGs0F6LOD5zr-FDIYJxshsssKbqKQ3P9XTP8O1m-gA3462K0iaVF_BEg
Message-ID: <CA+G9fYuedWTRHrhf_+eu+=D5QaQnEkwPaD5YoXWL7F2S5E29zQ@mail.gmail.com>
Subject: Re: next-20250605: Test regression: qemu-x86_64-compat mode ltp
 tracing Oops int3 kernel panic
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Jun 2025 at 17:55, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 17 Jun 2025 17:40:25 +0530
> Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> > > Please test below;
> > >
> >
> > Do you mean only this single patch on top of the Linux next ?
>
> Looking at Masami's analysis, yeah, I think you only need that one patch.

Testing is in progress.

>
> -- Steve
