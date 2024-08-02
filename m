Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B181C37AF
	for <linux-trace-kernel@vger.kernel.org>; Fri,  2 Aug 2024 08:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722586080; cv=none; b=dAeUxBUtFC9ndJadl50oXn1AJA7KYpnyyS4S5XbtaURA6Eyd0rtiP/fC6io1cyi7TGayFZQa4OsWMyDOjr3DgWaqTyFNxUMwSVwUu2W0uHGO2xrbWV1jdHhqhP4dCzTKzAsQHW4PUmgnuQbuxOw0Df3xrDmWlVKGTAC6N46Fw0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722586080; c=relaxed/simple;
	bh=zr17in5873w0D7frEzn9Z1BvBNMtjb7Z9MPgUwnjjT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r09ZSka1XO7JtZSF0h09fKC00V8MVFyFbG19oXQFNjEHLngucVrLcNjmk0iRqlHVHSqrdeJi1SimfODwXqrtKO9gFADt6K4jMDH/b+8DTMJ88r0LIA7Ho08HxhPSdAI/cxNKMn63olwtU4JDlJpojoez2ezMk7nHgPTCUz0Wq7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AUAsQ+Mc; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AUAsQ+Mc"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52f01afa11cso11699077e87.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 02 Aug 2024 01:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722586077; x=1723190877; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=escxcbn6CQpzZVjl6z5VUlZK10Wql4Sh9GSQYpnvjOs=;
        b=AUAsQ+McMuzLxujWxipKKVvsbaANZuzCFHavP/5J3zHzFJvUvDkvpAaZL33cXrMu/Y
         0rTRdYLnnucYRfSjI8KSy0GKyaYNsOaZL2iaJiu51UZIHTsURE5bn2IhoUfYHDtCMcE0
         Nd4y1L7xeJjpolmoCxHzlStf7VLdme0ZLZ0YMZ5BjHOwzHseqAg3OJ2MLXuy9Cnp9bJd
         Ki4dNeKgGelrJvkn8yujKLCxzbd6gkgiu2yrl4LMsUYyLlu3EyxFlLI7fefjt0ClHIhq
         wYFWg0zNp5CywCUim4xSql+1xIdmw85KyZEiY7qtlI344XdajqfQ9af6xXmSNWf7x1yC
         dXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722586077; x=1723190877;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=escxcbn6CQpzZVjl6z5VUlZK10Wql4Sh9GSQYpnvjOs=;
        b=SMzqCHUwlmdjnimuuYtY/mA6GGjOMbw7Zd1NQDZ0W4x1n2K0PDTKodNyxSMIyc8kC9
         jWZV1MAygjMqEOxYoYgtPn9goKwbtVkVmxO3UTzDBmhgbK7KbjtLgcdDZ0V4IWik01uI
         bZPSP1pBl+omMqkKJDl4QG0QFsAQ63V5nWvn87+Vn+eKz2EkhiSA6+ORn+E5e6Cie6Vj
         q6oafAQlA2V37KcgTt/7HHdEns5geQiNuD+PdreiCnjWE8kYA/PHIIvo2u9B0l0em+Fb
         mxBETarsPdFu3kwURoOTAQXy4hg2v+kGrE8dLShUJONo/Q+ry36ZePpxsBinC8+k5avM
         bS0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWjdWT1Mr7rSFA+4YsAmgWnxPfaKukfZj14Jjtg1rAKEvjScM+Xifrl6jSlX98lF1jvVUDcZu5L9hX7betAzC3CMU1rzPOJ7mCMqplIzAY1HQTQ
X-Gm-Message-State: AOJu0Yy4qnyD4Icb+yqrHWK8HyODlUzr6bHHOnyf+zXiHYANk+eR6nlF
	nmLddeHyOWs9MBZf/VZteMUmffGvdtJbJVvMtVrW74yBDRCBoGAmblEGlyMDfHhb/6baSYb6QVg
	7hQ1mUDho6nDYQ5xj3Ap1yRGEh3pBFp28RdQE
X-Google-Smtp-Source: AGHT+IG+xKO0y/MDURV7v5Ye973aEWq2ZhirgU9AGFasanOfoT8SM2QxjIQmJdkM6GFLTO/y2v5+4WlaF2T/WZYjysc=
X-Received: by 2002:a05:6512:b8d:b0:52e:f367:709b with SMTP id
 2adb3069b0e04-530bb3a34f9mr1726621e87.42.1722586076673; Fri, 02 Aug 2024
 01:07:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000052aa15061eaeb1fd@google.com>
In-Reply-To: <00000000000052aa15061eaeb1fd@google.com>
From: Marco Elver <elver@google.com>
Date: Fri, 2 Aug 2024 10:07:19 +0200
Message-ID: <CANpmjNMENK5NG+gjMm67--p-4h+c89bkSngoRJ3XTpkqrH0=Gg@mail.gmail.com>
Subject: Re: [syzbot] [trace?] linux-next test error: WARNING in rcu_core
To: syzbot <syzbot+263726e59eab6b442723@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org, sfr@canb.auug.org.au, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Aug 2024 at 09:58, syzbot
<syzbot+263726e59eab6b442723@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    f524a5e4dfb7 Add linux-next specific files for 20240802
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=174c896d980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a66a5509e9947c4c
> dashboard link: https://syzkaller.appspot.com/bug?extid=263726e59eab6b442723
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/8c0255b9a6ad/disk-f524a5e4.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/71d89466ea60/vmlinux-f524a5e4.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/ba8fcf059463/bzImage-f524a5e4.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+263726e59eab6b442723@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1 at mm/slub.c:4550 slab_free_after_rcu_debug+0x18b/0x270 mm/slub.c:4550

See https://lore.kernel.org/all/ZqyThs-o85nqueaF@elver.google.com/T/#u
