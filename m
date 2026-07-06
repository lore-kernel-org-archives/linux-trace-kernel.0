Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0198C242D97
	for <linux-trace-kernel@vger.kernel.org>; Mon,  6 Jul 2026 13:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783344835; cv=none; b=KBnOVLiiMcSh/ESV/p4ZmtgSDBTzVDatAhfxn/A0A8wkRyj8/HItT8w6MN4aHEROxGwWOFLOfv5ag2fGqxvqDspJoQbptSqLkEbpWVkhxFGosFicDjiWijzI8M0dqR/YtRYIZ5e//EDNTSHAe/P3U279HZX6GGQSJKm4H1mvlXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783344835; c=relaxed/simple;
	bh=ZpkMS8p842BDj52xuLNFF+u6ZVqIT8FxepTOedHzK2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=n5CdWK/8X5GPJd7982/oNyCHTi5rMOqEUE/zVJgT7KsY5543umNgGc3lasT+O1z1NWr9w2fLQJXhDZwNHdYHaD6VJ9T+qiqXgJ3wMOgQ/ufaJUlgZWvc1HlWnhVTJd+i9kAfhrkrIPJ7w+Xqi9J3dshapff2c8efX5D5USgxoLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fQwjYUEW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fQwjYUEW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783344833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZpkMS8p842BDj52xuLNFF+u6ZVqIT8FxepTOedHzK2c=;
	b=fQwjYUEWnEQe5UVGnNAYqy/epnb+wCfDXqYaoVEGJ7upZaSKTHhfZch4qoQQ3J6YVLEjLR
	4Hek33FwVnjngAKJ2NfDmzcMN2yQdRbGi1MPNWwOXVtcxyvXJbzD3J99vZpctk6ycVX70X
	f5pIiSwHk7IvftFoD87QT1Dz13pFQMk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43--V5STTL_NSadUceNyWIK2g-1; Mon,
 06 Jul 2026 09:33:49 -0400
X-MC-Unique: -V5STTL_NSadUceNyWIK2g-1
X-Mimecast-MFC-AGG-ID: -V5STTL_NSadUceNyWIK2g_1783344827
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AAC171955F22;
	Mon,  6 Jul 2026 13:33:45 +0000 (UTC)
Received: from fedora (unknown [10.44.32.112])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E62DA3653A;
	Mon,  6 Jul 2026 13:33:39 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  6 Jul 2026 15:33:45 +0200 (CEST)
Date: Mon, 6 Jul 2026 15:33:38 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Bradley Morgan <include@grrlz.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Marco Elver <elver@google.com>,
	Aleksandr Nogikh <nogikh@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Adrian Huang <adrianhuang0701@gmail.com>,
	Kexin Sun <kexinsun@smail.nju.edu.cn>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] signal: make send_signal_locked() take const
 siginfo
Message-ID: <akuusnRXP_tyuiel@redhat.com>
References: <20260622164029.11474-1-include@grrlz.net>
 <f754c4e5c82b45bcbb770aa8bb1f4ab1d87a0b0e.1782159692.git.include@grrlz.net>
 <20260706-karpfen-beruhen-ausschalten-9f2b0a55b8de@brauner>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260706-karpfen-beruhen-ausschalten-9f2b0a55b8de@brauner>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: nREsu8EDLxFwjGOG81t4RkwH-5Tkp_znbe1iPtjrQqE_1783344827
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Just in case, I can't read the code until Wednesday, but...

On 07/06, Christian Brauner wrote:
>
> > send_signal_locked() should not change the caller's siginfo. Make that
> > part of the type and keep the local rewrite on its copy.
> >
> > Suggested-by: Oleg Nesterov <oleg@redhat.com>
> > Signed-off-by: Bradley Morgan <include@grrlz.net>
>
> Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>

Agreed, but IIRC this change should be rebased on top of -mm tree (I sent
the patch which changes send_signal_locked(), and thanks for your review btw!)

And, again iirc, with that patch "make siginfo const" become really trivial,
we only need to add "const" to every "kernel_siginfo *info" in the
send_signal_locked()'s callchain.

Oleg.

