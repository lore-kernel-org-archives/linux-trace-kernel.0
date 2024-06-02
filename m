Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EA06EB74
	for <linux-trace-kernel@vger.kernel.org>; Sun,  2 Jun 2024 20:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717359089; cv=none; b=lquqzWAjF0E2OAg8L8C/w0eYYH1CcFqOq//Akky1FRZxZuZjAuwVJgxf9raDX7wmwMtoOp/ei38x5JnCw8B6omGgav9TT8E4VJOvO6g5YM+9sB15BQZBDYHIbxsDDR/ocf19LO7XUJxjhYaAOww0mq98QWgdt3YOGZo+N8e1qUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717359089; c=relaxed/simple;
	bh=pPpQRofU4aUuWzH8F/QKbmIvQmhWX6HwGWlPQg5XjJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pbox+ji2P3O8yRQbXOgFjJGrq7gaaISEAiz0L8Z9P+UHK4KUxxF4LGj7qz551nEWWjoYDgPHR0DsRxDWvm1wDHH5TN01jVjPoR+UFEkbQbcRK/yZMtS7+N9JWbl/NpGCMx+VRHVEb/5r7EqC7bE9RpdqfoaCPUaZVG6AmXX6dNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TF/kv0wr; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TF/kv0wr"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e73359b8fbso51366561fa.2
        for <linux-trace-kernel@vger.kernel.org>; Sun, 02 Jun 2024 13:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717359086; x=1717963886; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ePqimL8VaYhHEJxz6pSQAbNa/K23yw/URyexsY++IVA=;
        b=TF/kv0wrvU7CMD/1W6pdUuFiz9Lbwi4grNGC/o0BgG9oAogSjQmTfmkE8VCpSAcYoZ
         5jDtGz0A02AyWPDSM1vbeb8dBu+Czmf2sPpMXUPNC+OD2CcK8oA/3/wUhnSMDNuwNqjM
         T7IACHmfTs2o3k7Y2QBqEiFfXliZzGut61kEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717359086; x=1717963886;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ePqimL8VaYhHEJxz6pSQAbNa/K23yw/URyexsY++IVA=;
        b=B6kpJF2tYqiWZkfqmHGdYwXLngWBv9RSAgznZfVTyPkjfz1A7ZZZNP39B0IobzK9Dh
         9vWbTAHEW/AW+42v9XNdT5YETL2BynUAzHe2zZhI6IJxtrhtlFig9usTFsZMFvLAu73O
         okedJ29Z2aK3dHWgpUZShCd+UOGRZX2AKpG1a+SsIqIFj32fa1blX5r3lRDQtD4mriiu
         83c7q4QIGpKfhQugXC54KXtp7/IFYtvVBh9qnZeIGX21dboE5Rpldf91/Xyzvwi9v34M
         BdDCu1Al0QplQyJ6FPoJ7It0fKMiYx/oekTOhSlsG4DshkMWNJ08pfKwqOrEjNArXSJV
         ZDsg==
X-Forwarded-Encrypted: i=1; AJvYcCUsoig+2O8DNo+QZo2NNR40Gu7FWm0vjgXE957yD1uNegBNcj3+TCEx/XApI567B2FWNZ/5Xu8gGR8j20y10kW5wn0pPCOz437y44MyTwYqaetY
X-Gm-Message-State: AOJu0YxRlrpujeBWl8ZfLEvR0XxuExXuJrMv6AUSLQHacdzc/fzgC5V6
	AK4JXEZxnI+VOWr1s8TfOQ6ggGzYxbAcmTbzc/aTB9Q4a8/buKdYzdBHufClo/guVydPB3+3EN4
	y
X-Google-Smtp-Source: AGHT+IFrTqj3vGByNdB4mWWqrr59dtp7+MvHAYCw6JEnp+taNb3EGr9XMUyNJen78o33EpZzyy8Tlg==
X-Received: by 2002:a2e:994a:0:b0:2e1:a8ca:6166 with SMTP id 38308e7fff4ca-2ea951fd34bmr51121291fa.43.1717359086020;
        Sun, 02 Jun 2024 13:11:26 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ea986ccc4asm8317171fa.72.2024.06.02.13.11.24
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jun 2024 13:11:25 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52b8254338dso4199052e87.2
        for <linux-trace-kernel@vger.kernel.org>; Sun, 02 Jun 2024 13:11:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUeCOtK2oHydjUg4/RDdz04uoJuXNjsZKHS1vujKi7lAlbxM7l2vSxG/httCf1r89Mkl6ftYTnYp1jm8SHlr1FHkwo2jNn3S5FCWbHGjOAP9StO
X-Received: by 2002:ac2:5dc3:0:b0:51a:f689:b4df with SMTP id
 2adb3069b0e04-52b896bde2emr5480833e87.44.1717359084107; Sun, 02 Jun 2024
 13:11:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602023754.25443-1-laoar.shao@gmail.com> <20240602023754.25443-2-laoar.shao@gmail.com>
 <87ikysdmsi.fsf@email.froward.int.ebiederm.org> <CALOAHbAASdjLjfDv5ZH7uj=oChKE6iYnwjKFMu6oabzqfs2QUw@mail.gmail.com>
 <CAADnVQJ_RPg_xTjuO=+3G=4auZkS-t-F2WTs18rU2PbVdJVbdQ@mail.gmail.com> <874jabdygo.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <874jabdygo.fsf@email.froward.int.ebiederm.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 2 Jun 2024 13:11:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgkgtCjr3aHFnFifYtKnvet0M9jehfMFYhYpL_F7Jbmtg@mail.gmail.com>
Message-ID: <CAHk-=wgkgtCjr3aHFnFifYtKnvet0M9jehfMFYhYpL_F7Jbmtg@mail.gmail.com>
Subject: Re: [PATCH 1/6] fs/exec: Drop task_lock() inside __get_task_comm()
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Yafang Shao <laoar.shao@gmail.com>, 
	linux-mm <linux-mm@kvack.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, audit@vger.kernel.org, 
	LSM List <linux-security-module@vger.kernel.org>, selinux@vger.kernel.org, 
	bpf <bpf@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 2 Jun 2024 at 10:53, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> The read may race with a write that is changing the location
> of '\0'.  Especially if the new value is shorter than
> the old value.

It *shouldn't* happen.

So 'strscpy()' itself is written to be NUL-safe, in that if it ever
copies a NUL character, it will stop. Admittedly the byte loop at the
end might technically need a READ_ONCE() for that to eb strictly true
in theory, but in practice it already is.

And even if the new string is shorter, the comm[] array will always
have a NUL terminator _somewhere_, in how the last byte is never
non-NUL.

Now, the only real issue is if something writes *to* the  comm[] array
without following the rules properly - like writing a non-NULL
character to the end of the array before then filling it in with NUL
again.

But that would be a bug on the comm[] writing side, I feel, not a bug
on the reader side.

               Linus
