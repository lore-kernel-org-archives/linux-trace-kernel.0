Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC3017C3
	for <linux-trace-kernel@vger.kernel.org>; Sun, 29 Oct 2023 05:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RwapE4d7"
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1252C6
	for <linux-trace-kernel@vger.kernel.org>; Sat, 28 Oct 2023 22:22:55 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6c4a25f6390so2311228a34.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 28 Oct 2023 22:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698556975; x=1699161775; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sB1j55JC/El1p0jjkjVIArkqbmShYLGKj4KmRysP+N8=;
        b=RwapE4d7hl8Bkxl8xX035KiVZBsxWpW+02VCNltiOLygXFSFg1epUSEbUEDDLdKGgP
         c9YXOv164yVT4uFdJlwkSiuiGdibV/srakpEIxYBts0BkVvMuuM26nHytR8SMEdb0dR5
         o7rqGdY0XFWeoMFqSm9lgnzE21XQCiVXUNv7jgtftQem5qHDjqphSVYh4x6+gRw9jVVU
         evnjbAX6OgXpWtQ9TBhXrjrjNS1VRGzUcPsDDJAH6mzLXtZw9kD5vPm/NuMM1bxdlQmh
         PZNGx3wyrJmA0cWmQlq0X2qGm2Yl605+pQGA2Nf8oT43MgNLThqxM97bVn9yDVc6i1kS
         0U/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698556975; x=1699161775;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sB1j55JC/El1p0jjkjVIArkqbmShYLGKj4KmRysP+N8=;
        b=R+VJF18jM+m7ybYvlWEMAjH5tWaHdfXFu5cHjZu0DrLpfN+vfyBHCquCAqfpJ9oCkw
         viq6Xg673ZMODTRVW+34BHiqwUwAf9wMJP3/gAgTLFWFQGvmoAPjYmDzX3uNBwVZ/1Ae
         vtCeG6U/dczZI9cUAiqPaDYdwmyrTHDtAeIXjb0+oLoXAdmQv/7k9OEPcp7hpsstHlN8
         ZZmWPiWtcaaP2LirBoUQE6wbBMUdkufnomGOM+gfa+nSfhdKIC35RwI7MrNB+CLLeqsS
         sBXwmTWEuAvSWp+2vZOjyuM4+a3GPK5kwWNjyYMGJxUXFM+hT01X3ugvOQvVrXB15mxY
         SjGA==
X-Gm-Message-State: AOJu0YwKIhvXoPj3TJr5DF75XfbPYvJ7DoKcAljhAW2p+6fe/MPs1n4l
	gr7cCsZI0i3BpI6gyp6k0HrJctEmTKbjs/Qh7tkQlg==
X-Google-Smtp-Source: AGHT+IFD5noruhyvzyxMRl/i4pk8euQ/2NViE3YRCrT4LW+KBgiNugVIsrn+zfY8Ma/tD2zYcnXm9FZYdj+zqt5iW04=
X-Received: by 2002:a05:6808:209a:b0:3a7:2524:6d3b with SMTP id
 s26-20020a056808209a00b003a725246d3bmr7421000oiw.12.1698556975240; Sat, 28
 Oct 2023 22:22:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231028163749.0d3429a1@rorschach.local.home>
In-Reply-To: <20231028163749.0d3429a1@rorschach.local.home>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sun, 29 Oct 2023 10:52:43 +0530
Message-ID: <CA+G9fYuJF42KP-j5LNa2FMqDr8wxHFMXm2pNe=SRNnXvqKrMrQ@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Test for ei->is_freed when accessing ei->dentry
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Ajay Kaher <akaher@vmware.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 29 Oct 2023 at 02:07, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>
> The eventfs_inode (ei) is protected by SRCU, but the ei->dentry is not. It
> is protected by the eventfs_mutex. Anytime the eventfs_mutex is released,
> and access to the ei->dentry needs to be done, it should first check if
> ei->is_freed is set under the eventfs_mutex. If it is, then the ei->dentry
> is invalid and must not be used. The ei->dentry must only be accessed
> under the eventfs_mutex and after checking if ei->is_freed is set.
>
> When the ei is being freed, it will (under the eventfs_mutex) set is_freed
> and at the same time move the dentry to a free list to be cleared after
> the eventfs_mutex is released. This means that any access to the
> ei->dentry must check first if ei->is_freed is set, because if it is, then
> the dentry is on its way to be freed.
>
> Also add comments to describe this better.
>
> Link: https://lore.kernel.org/all/CA+G9fYt6pY+tMZEOg=SoEywQOe19fGP3uR15SGowkdK+_X85Cg@mail.gmail.com/
> Link: https://lore.kernel.org/all/CA+G9fYuDP3hVQ3t7FfrBAjd_WFVSurMgCepTxunSJf=MTe=6aA@mail.gmail.com/
>
> Fixes: 5790b1fb3d672 ("eventfs: Remove eventfs_file and just use eventfs_inode")
> Reported-by: Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

In the above line "Reported-by:" is twice.

> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Reported-by: Beau Belgrave <beaub@linux.microsoft.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

I am running tests on this patch and will get back to you shortly.

- Naresh
