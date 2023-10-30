Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E4323C3
	for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Oct 2023 21:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="la7Bwm7r"
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A145ED
	for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Oct 2023 14:41:43 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-7b743c50331so1989829241.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Oct 2023 14:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698702102; x=1699306902; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SHsgRHhoqkaq8kE8+zLtQqJ+j1HxGJt5UjJB+ZsFZsk=;
        b=la7Bwm7rkChaD8r1nAg4fHUfznKQxUPUEBtPFE/vPZUg9yeaR8hTMv41Fsxt/WIVA5
         JvAOaN6KpTfLYqu/HkVWFujhLALcsHpHI05sJY78mr1QdviBOFEwC2ESc+m0eUslTA7x
         662Grv5JAIKFANsnicqikkBALBimL81FzFoET+S2qwU7qPZqdggwM7Was3dSheyN7yqI
         Zi6qfqu0McsbepkLo1nX6+CQUsurd7VvqfoHVNx9nSaSnJxUxwYOVIBwSsZjXlPdybov
         neRCo+knEpfRtWLwy/dEaueW20GYoMSUQObTFTEDU6BIllK82QhC6dD7IiXBOzkyuFBx
         mjQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698702102; x=1699306902;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SHsgRHhoqkaq8kE8+zLtQqJ+j1HxGJt5UjJB+ZsFZsk=;
        b=ldtUxw+ab3yv2UdeEf1KoUoLNIRAGpFovemGbAFZXdqEuBVgxso8B4cLuXzTmipRrx
         HES5qHMs3bDENNyvHmR9+nJ2ej+byaB7VfRqDL7psYnn4djeRBje3L70BAJc08YZOjvo
         EyEG2LANgaJKbV4/e8wkvv95DCz6Dncv03FgPqW0u/VQLeyQMeBgxycwFzxMLMCmp8r7
         ObBJq05n8Z6NlcogX1E3GIBc74jHcOjOj0Jo0t62U23jH54WsXxUMH44KauREbHapMMk
         2MploTLhLDcEDvNrrr7RrwfogoYtqKNJMHTMMQbmPfqEMfOPddndcrk8D5wceWNHdhq2
         bq1g==
X-Gm-Message-State: AOJu0YxH5ul/gzWKw8i6QZ7HkAMdCtsfJizJPgh5WTpV0rDfL3Coxnx8
	DfxcfX+1B3mIhOnHZIlb1XfFAGfl1jLt0lWuho+UifNuG9XfiGoirQlPEg==
X-Google-Smtp-Source: AGHT+IHdrDzSaKyAEQHMrcY+eunWkBLKSBqisQlp1AqrNYguLLAo8p3k3PrpAUTQupofP29OAkeErE4yI57DrAICTTU=
X-Received: by 2002:a67:cc16:0:b0:452:8423:e957 with SMTP id
 q22-20020a67cc16000000b004528423e957mr9523624vsl.28.1698702102537; Mon, 30
 Oct 2023 14:41:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231030114047.759c7bdf@gandalf.local.home>
In-Reply-To: <20231030114047.759c7bdf@gandalf.local.home>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 31 Oct 2023 03:11:31 +0530
Message-ID: <CA+G9fYu5VdDPB25croT8OEFRcfxMSHRduL0EK8ct7EVWN3t5aQ@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Hold eventfs_mutex when calling callback functions
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	"Arnd Bergmann <arnd@arndb.de>, naresh.kamboju@linaro.org, Beau Belgrave <beaub@linux.microsoft.com>, Ajay Kaher <akaher@vmware.com>, Andrew Morton" <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 30 Oct 2023 at 21:10, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>
> The callback function that is used to create inodes and dentries is not
> protected by anything and the data that is passed to it could become
> stale. After eventfs_remove_dir() is called by the tracing system, it is
> free to remove the events that are associated to that directory.
> Unfortunately, that means the callbacks must not be called after that.
>
>      CPU0                               CPU1
>      ----                               ----
>  eventfs_root_lookup() {
>                                  eventfs_remove_dir() {
>                                       mutex_lock(&event_mutex);
>                                       ei->is_freed = set;
>                                       mutex_unlock(&event_mutex);
>                                  }
>                                  kfree(event_call);
>
>     for (...) {
>       entry = &ei->entries[i];
>       r = entry->callback() {
>           call = data;          // call == event_call above
>           if (call->flags ...)
>
>  [ USE AFTER FREE BUG ]
>
> The safest way to protect this is to wrap the callback with:
>
>  mutex_lock(&eventfs_mutex);
>  if (!ei->is_freed)
>      r = entry->callback();
>  else
>      r = -1;
>  mutex_unlock(&eventfs_mutex);
>
> This will make sure that the callback will not be called after it is
> freed. But now it needs to be known that the callback is called while
> holding internal eventfs locks, and that it must not call back into the
> eventfs / tracefs system. There's no reason it should anyway, but document
> that as well.
>
> Link: https://lore.kernel.org/all/CA+G9fYu9GOEbD=rR5eMR-=HJ8H6rMsbzDC2ZY5=Y50WpWAE7_Q@mail.gmail.com/
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>

> ---
>  fs/tracefs/event_inode.c | 22 ++++++++++++++++++--
>  include/linux/tracefs.h  | 43 ++++++++++++++++++++++++++++++++++++++++


--
Linaro LKFT
https://lkft.linaro.org
