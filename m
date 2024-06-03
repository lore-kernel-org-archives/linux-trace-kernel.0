Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D61B13C805
	for <linux-trace-kernel@vger.kernel.org>; Mon,  3 Jun 2024 22:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717453451; cv=none; b=f32sfOOVitNs6rh4THkrXchGq9Cc+IsHAeux5bJbtuALau3/1vs3zSSxirokiJ+WZprb9PvucDBBSpQkVJdCVGUAUYh/6r6l6lOuhaOdv3u40Nwdjnh3W2kQbdxgQsP8O9ZJ/Ao26QdVGqXR1FCpGxiXpRjcLWRh9aJNsEN3TdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717453451; c=relaxed/simple;
	bh=AFfU/PEC+zuhNdQ2tMeUL2Lz6Nhx2hQNDlZEumLFtHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q0m9T/FwNcqy0R/uPVYl9INutx4xOAafrS2NDEGjcPaD9YPK+QO1tfpVayRHFNnOoeMTniPjs1njJnT5P7OMq4KVgzb3kq9a5nKGa4D/H6SpnARQhdQwcbUoV+sNBsmq5bPECuAilgyWAKmdf+w9iDHV/gk7NsL7oC0R09fpfag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NvlNM94t; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NvlNM94t"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a626919d19dso877474766b.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 03 Jun 2024 15:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717453447; x=1718058247; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vUfCTj7RhneZiyZGwU4My8ep0xDaKOVngko5RyaH/ts=;
        b=NvlNM94t6sll7sF2XotPG849RkvwqA2mzJ7yLghmdoWCe/+h99vmOGCGjvSseh3s6r
         S/GfB/Qh0OaiI3bRW58c5ghzkxxojQrnJFc064N7uvD/XG7B0PItbqmuoTwHykQXxJCr
         +nEcQxl8fJ8V30NsnGDoJNRo9gdlJTmDzbEkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717453447; x=1718058247;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vUfCTj7RhneZiyZGwU4My8ep0xDaKOVngko5RyaH/ts=;
        b=oygEkGEzRrbvLcWXbxPu/m5lxMrL6sR3WzzWGXmRn16tqmJUvh3v36eZCO5GHLHdkN
         UeiE3ZjCkBkTOlmUZV4abYzjv53YgaF0XU5v/PZ/6p9Lvk4OU/sosdfDWKE+k+DiqQI1
         O1SvRXUiRbnVxwz2CF8GBLIAnBrFMg5+7m7fmwMfTWK7qzRd6SHbsCMfERtWuvvsdt3+
         fMIL7XBJfFU2VZqmn6DI55wd6Ala3TgLP840zqUiZ0OP+5Nw4i1fC3uhdMdRps5wkzy8
         i1m+WqpGYjsO8raBZoitXVPEoPVN4G7EjwQ35iDaBjETSbvPbttOssE+EyY07JlfQVWX
         RatA==
X-Forwarded-Encrypted: i=1; AJvYcCXL47cS/wxR1er93giBMO4J1+rFwcE7KPIrIJ1YUYo0rtn+PNOREE2wJerBH4Yo0WL+4eVw0oFtbB6Q48MUy43/CM+UT/SqaHc90aCR2WRX60Pn
X-Gm-Message-State: AOJu0Yzh3aWhb++Laut910GYOv36b2pkq249txRLedV8S8wh1vjo0+Ly
	zQKvnWqzoaPtxqIyFH2rPuZa+oXfz4RDMxh3hvSQFdORRwmpPm9GZr8IzspVJx5/4BHLF8fAJjZ
	Zkjrd9A==
X-Google-Smtp-Source: AGHT+IHL7Kcg/Myd7Nl2vESkurgm1MyursmJXoLTRZlWikDgw6TXLaWHxTWi5cAOeKyzS+ymygu/XQ==
X-Received: by 2002:a17:906:e952:b0:a68:8987:891d with SMTP id a640c23a62f3a-a69546aebf8mr62071266b.30.1717453447031;
        Mon, 03 Jun 2024 15:24:07 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67e73faa76sm536984166b.75.2024.06.03.15.24.05
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 15:24:05 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a68ca4d6545so380648466b.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 03 Jun 2024 15:24:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWDSNEB8aynkOAG2vCjDZLb8eje1mhLLW1ojYW2odjJbbyb1sVIXDXcGqpojFOSNuW1p/O1ORKZ8sRTuVZKBabZb+PTquVEyGTrH/w8juvNiMjp
X-Received: by 2002:a17:906:d217:b0:a62:49ae:cd7b with SMTP id
 a640c23a62f3a-a69543e118emr67505166b.24.1717453445163; Mon, 03 Jun 2024
 15:24:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602023754.25443-1-laoar.shao@gmail.com> <20240602023754.25443-3-laoar.shao@gmail.com>
 <20240603172008.19ba98ff@gandalf.local.home> <CAHk-=whPUBbug2PACOzYXFbaHhA6igWgmBzpr5tOQYzMZinRnA@mail.gmail.com>
 <20240603181943.09a539aa@gandalf.local.home>
In-Reply-To: <20240603181943.09a539aa@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 3 Jun 2024 15:23:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgDWUpz2LG5KEztbg-S87N9GjPf5Tv2CVFbxKJJ0uwfSQ@mail.gmail.com>
Message-ID: <CAHk-=wgDWUpz2LG5KEztbg-S87N9GjPf5Tv2CVFbxKJJ0uwfSQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] tracing: Replace memcpy() with __get_task_comm()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Jun 2024 at 15:18, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> The logic behind __string() and __assign_str() will always add a NUL
> character.

Ok. But then you still end up with the issue that now the profiles are
different, and you have a 8-byte pointer to dynamically allocated
memory instead of just the simpler comm[TASK_COMM_LEN].

Is that actually a good idea for tracing?

We're trying to fix the core code to be cleaner for places that may
actually *care* (like 'ps').

Would we really want to touch this part of tracing?

            Linus
