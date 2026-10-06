Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6506A3E8C77
	for <linux-trace-kernel@vger.kernel.org>; Tue,  6 Oct 2026 13:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791293370; cv=none; b=mDY5BSzaPfRKRDUUrmbUGXj0UufR7YbYe3I+pG/GZxSCmZxbh/STcuGcZMA6sILAtTxI7d0NtQBP/f4s+2Azp2kDZNzbEi71cLec/MlAItbSv6FSjg69M61N1HyTJ9q7GdT0A0H0Kzc+jQi6I5OItKlPKvOMbBNFIWrQCoNK7n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791293370; c=relaxed/simple;
	bh=Jd9JtVPsfeTOoO3gMKQ1tUTrmD8+wav6j6ck+BCGZGY=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:MIME-Version; b=Hlj1RMbJ75W12yfnBqReuxsUwRWQdXhdHCYU7mYYuxEsg76CgoD61UrjJg6+pEEXcooaw8wMojfMW2zAZzG6at1IPxwaCLC/WklOtWCTZmy64pIuEhp6WIy5x4kC92YmXZoQyAzEjl471lyModOdsMENfUMo29dMx4CgmwmXJV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hc3znzuP; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hc3znzuP"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e2e064b932so15045435ad.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 06 Oct 2026 06:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791293369; x=1791898169; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZIuf2SgMEBmvnAUyRYToawlWCUpnefJ0N51oaV1vfS8=;
        b=Hc3znzuPKQ/mwixmIQP2ycX4J/cOUH7DraEc+sktZOe9jRKPPs6YMTouF9E4VMRVqm
         7LWng5g/bGwCwTSv3VFvrQctNypjYu9UO8RIf0Pd5pIqTBJwtFyLWRiYGhMN0fi9MHIn
         1urvLWWsYJdD55WEwFP6ORXTWawEBByNUzEQPdvXrMqHEzDqM7bYVtT2V1uxnHKJvl+I
         F6uDcAK4vu/HmRaaKkaBqS89WZjsetiwDibFmQOxKNAzpQSoXyK4c3ASxLeK3AfVe2fk
         MK0swa8XlJr6WYakGexByrteLw3c2r55Sv3+QfevEBla1ErvxC8OVjkb8//7z7T4JB9H
         ZmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791293369; x=1791898169;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZIuf2SgMEBmvnAUyRYToawlWCUpnefJ0N51oaV1vfS8=;
        b=rgG+oJIA7Ttk2NP271hsXzkdK3oOBCRKQatJ7Atd65WfgfoQObyzgm+1YVMy3foUSS
         uRNpMkjRiKT1HZ5uB66Ny4d5qCDVoruAwdrq9a4QJ/3JqrcaEHYZy8Dv0x6jSryp9JwO
         yZ+letNVKK3OyUubj9nGTz1/oNZ4ChbNXx6s+AFdP9KsvA8Hju5/NN3HHyVbjAXdxhKK
         uNx4w26wOcazxRE40QGM7o4vzpdbyu92xlQlPpXPsaOgT1B8zfJCqN9+RM100I9F6G4o
         WvddbIm2FqDE2P1PNc+KO5n66ZbmbrhiqTPXya+hy730eWc1+pBPGz7E9mtTVjZevDuF
         B9dg==
X-Forwarded-Encrypted: i=1; AKwUvBz8+CdWWqPuDm7RS/mcHbY1qtNh/aBgZkroVFWv/VOceRSpW5B4WWg3dj/aAxs3gxuekCBJo9kv4NCBPIlU0ZxoX3I=@vger.kernel.org
X-Gm-Message-State: AFuF++mUm+dx2AF9lsabJ1n6Q52WKwxMiT6PiqCF+dPxK2l9P1iP1SsP
	6OlCpmEzQmRPviYlnVxjGSWXz6DCIJ8P4haQjIDbp7G8m0L8NYmG5hq5EQQf1YNM
X-Gm-Gg: AYBFou0zqJJelJ3ZqPwKLlcG67j6KEOmAvk9bE+odq9aCWRCWGZ8fx8y/SKSJEieE5d
	6xmqQTFgqAKWCKwvflfBYkmX+l3ubONJc9/tS4orPpFg2Us3RTt1K0f0W3QadbXdSKwcadGCl3c
	/6ZuNuPwmu/c6zeoUHE0IHlwAEkU26vE3th2sB1vsFMOwIcra5dpwg0EwCfOUwvxd0mpnGGT2Jr
	Wi+00BVwek8HXpRNRUdCLNyE01DGi0/zE8KYXU6YAVcKmNJ4+OjJf8b9LMCIvxoZ0zgxO4UZ3gZ
	fq1Edc4udMzQ92j3uVIawILfwfQdanH1NZBYJUoG9V8R4TiR5JGyiJCi/VyKcarrbyO0P4zgfWQ
	yleTmBaBZ2KnG6l17ZiVowyw1HsTnTMvRV8+SEg3T1DuGhP6R5rXtI2l6/rj3K61ji/kTVlY+1l
	M9RDV4DJpM6DcN0fiLR/If3Z6sx8Qe3QCiM3qj+veABrUwVe17dg5VrH3dwvtDt+BewWycPf9ce
	h2WtAeLt8Dwr+9kfT2/4y26rChgs66S/md+Ih0oQxHs67+/1zO3SdIIWov+JObvnyeWGG1IXkzj
	BaVy
X-Received: by 2002:a17:902:d988:b0:2df:a64a:756d with SMTP id d9443c01a7336-2e51049827bmr86635015ad.33.1791293368596;
        Tue, 06 Oct 2026 06:29:28 -0700 (PDT)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e5a55b6e01sm22625735ad.9.2026.10.06.06.29.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 06:29:27 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 06 Oct 2026 13:29:26 +0000
Message-Id: <DLXSI4BSRE5F.1TLKCBUAGNDFQ@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Gabriele Monaco" <gmonaco@redhat.com>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>
Cc: "Nam Cao" <namcao@linutronix.de>, "Wen Yang" <wen.yang@linux.dev>,
 "Tobias Schaffner" <tobias.schaffner@siemens.com>, "Viktor Malik"
 <vmalik@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
In-Reply-To: <20261001152042.124445-11-gmonaco@redhat.com>
References: <20261001152042.124445-1-gmonaco@redhat.com> <20261001152042.124445-11-gmonaco@redhat.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Oct 01, 2026 at 05:20 PM Gabriele Monaco <gmonaco@redhat.com> wrote:

Overall looks much better.
Some of the code reimplements bpftool, but it's user space.
It can be cleaned up later.

> +$(BPF_DIR)/%.o: $(BPF_DIR)/%.c $(VMLINUX_H)
> +	$(QUIET_CLANG)$(CLANG) $(BPF_CFLAGS) -c $< -o $@
> +	$(Q)$(LLVM_STRIP) -g $@
> +	$(Q)$(LLVM_OBJCOPY) --remove-section=.rel.rodata $@

What is this for?
Released libbpf ignores it with "skipping relo section" message.
Removing the section only hides that some pointer in .rodata is left
without relocation. What is it?
libbpf in bpf-next needs .rel.rodata to resolve pointers to functions.
See commit b223044a68d5 ("libbpf: Resolve pointers to functions in
read-only data").

> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__uint(max_entries, 10240);
> +	__type(key, da_id_type);
> +	__type(value, struct da_monitor_storage_bpf);
> +} rv_mon_map SEC(".maps");

Why hash by pid?
Use BPF_MAP_TYPE_TASK_STORAGE for per-task monitors.
Once there are 10240 tasks bpf_map_update_elem() in da_create_storage()
fails, the error is ignored, and the rest of the tasks are silently
not monitored.
Task storage is freed with the task. No need for handle_obj_cleanup,
id, target and PF_EXITING.

pw-bot: cr
