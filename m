Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C99262149
	for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Feb 2025 17:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739293237; cv=none; b=WqAI4iqGbxKxN+JDjP8ced5fyLAF8QBdIc65EVH9nIw8K8BZzX5XulSVYEGjJ2Eoshh5GfOy4YoECoLrol82VgwuqgVLqLncpyogUcYO7sUjfKGO19BM5uDbN0FktsboDdFWf+ksIHWIOS/pKMqeRCLv04Ufe27IIhgQ2AEpYSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739293237; c=relaxed/simple;
	bh=Ijl1870gwz6IX+/MESbsYzIdZlpRJGmSg/J77w9i4U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awjIn7MAUJ4i7VeHi+Ti4TMCzxaQy08B578y/rOy91Lb7c5uhtHEZj3mYjIFO44vtws6Ku4APdPtk2U4c+jU3RtWezmiWUEdgBtLeqr0Y/55eIeX5lM73a2jWfAaUI5zkdA5OUR/yhU8HDfySG3Mx2Z8x6iJ7PxywQrqUc2Ebr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JevEqJT5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JevEqJT5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739293234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ijl1870gwz6IX+/MESbsYzIdZlpRJGmSg/J77w9i4U4=;
	b=JevEqJT5tNlKdleFa5g8Br/VKeH4zKOyXS0H/jWeyFLaro90B70z+cgRJwpUNySQFXR+JQ
	XkkVPfqVYH38LM5onEzy982uuRBcwj4W8sfFwGBbbzDm7RY3f1cieCddxv2its5uzcuBWl
	qmLQoCvdPehhpxDrQeNquBARB1pV2Zg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-359-DUCuPesZNGyoR9XuI7pEIQ-1; Tue,
 11 Feb 2025 12:00:29 -0500
X-MC-Unique: DUCuPesZNGyoR9XuI7pEIQ-1
X-Mimecast-MFC-AGG-ID: DUCuPesZNGyoR9XuI7pEIQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D32C91800872;
	Tue, 11 Feb 2025 17:00:17 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.32.197])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 5438019560A3;
	Tue, 11 Feb 2025 17:00:09 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 11 Feb 2025 17:59:51 +0100 (CET)
Date: Tue, 11 Feb 2025 17:59:41 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, Kees Cook <kees@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>,
	stable <stable@vger.kernel.org>, Jann Horn <jannh@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	Linux API <linux-api@vger.kernel.org>, X86 ML <x86@kernel.org>,
	bpf <bpf@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
	Deepak Gupta <debug@rivosinc.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCHv2 perf/core] uprobes: Harden uretprobe syscall trampoline
 check
Message-ID: <20250211165940.GB9174@redhat.com>
References: <20250211111559.2984778-1-jolsa@kernel.org>
 <CAEf4BzYPmtUirnO3Bp+3F3d4++4ttL_MZAG+yGcTTKTRK2X2vw@mail.gmail.com>
 <CAADnVQJ05xkXw+c_T1qB+ECUqO5sJxDVJ3bypjS3KSQCTJb-1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJ05xkXw+c_T1qB+ECUqO5sJxDVJ3bypjS3KSQCTJb-1g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 02/11, Alexei Starovoitov wrote:
>
> > > +#define UPROBE_NO_TRAMPOLINE_VADDR ((unsigned long)-1)
>
> If you respin anyway maybe use ~0UL instead?
> In the above and in
> uprobe_get_trampoline_vaddr(),
> since
>
> unsigned long trampoline_vaddr = -1;

... or -1ul in both cases.

I agree, UPROBE_NO_TRAMPOLINE_VADDR has a single user, looks
a bit strange...

Oleg.

