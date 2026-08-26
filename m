Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CADB3B5301
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 21:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787779176; cv=none; b=mwBJEbGGd+JZmGs/xxidx517lRAjz3e3WZZ2kC6uwD5DffWV9/gqwdH/ycXYSdH3B1ZPWm1KV97JqyzX9TFgWiY3YL1tEx4edOBKYBqlAUqu+acZpmYvn6jXG705eFln3kn9palu1LrvlNpJd+WoigS26ksM4j9G3B/HsMwK/6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787779176; c=relaxed/simple;
	bh=zOU3jhEls2nlcQi6nn7A7bCR5iYoUqPrg5AVUP9NoEo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cYbuWQXSqJMxI8w8ENDhzAz0wrYxaHcPlgvjYqtXQhoxYh/FHjdGj2j2BSBhPIvkZfxj1lh2lAufNFzh+IyEBAtraNGWCcrFYVGhq2nJKx9L94MdaEfzeITtwh6xhIYZ5wwbAV5qFj5iKajMnvXqaXKq6gmtm0cKp3ktq8raoZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QDbchPww; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QDbchPww"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787779174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hs9Hk1Yz77p64quQu3QJjbDqz+Gy/YAoNjsZDx24MPE=;
	b=QDbchPww8uzHwoxY/6sG4PvrtSJxjiOcXvrTvT6C/tHZROIAXH92cVcmDs0HoVuU1y36mT
	NQaEKlsDnhxch8dws58TrfC3U8LrdQ9ml2P2FuLwcpfW+7MeVcGNjjUWUtHERjNT7eNF2O
	fQZyI82NigR5lt965+1FdV7gIuYZ2b4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-PLGi5NJnMYCS_a-su-169w-1; Wed, 26 Aug 2026 17:19:32 -0400
X-MC-Unique: PLGi5NJnMYCS_a-su-169w-1
X-Mimecast-MFC-AGG-ID: PLGi5NJnMYCS_a-su-169w_1787779172
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93771aa0379so4965485a.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 14:19:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787779172; x=1788383972;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hs9Hk1Yz77p64quQu3QJjbDqz+Gy/YAoNjsZDx24MPE=;
        b=cUjwog9gd/lolW+blTa/rMiZBBBA3BNSoeirG2MOk/QzOMO4wppndpz9eM9WpIgMFC
         1o9vaXNaexxGKEn+14Nvq857kf4bQr/Kp4czt/NBzmeafFOXVVPU8TYEHSlC3CHPbmfc
         NCtL0Q/dIQWX0fnPZiexqM42+7BvWhbj+h4kNZm7F6KpXmCPokIUNhTkzJJKAVcUndRx
         IHNPWkr+CwAOyA8hZHb6XEtNn17vfv0Gs/XPRvnloWxgLxu5jKf95YSOfmlzKsua3dlB
         7q9nOGjTwYpLxYywjlHK+4T1J0NjbkXy/BkfA6knxSS3CXK8WxFiq/rrej0iPX3Sq51i
         494Q==
X-Forwarded-Encrypted: i=1; AHgh+RqcSsvmIApCJsfKENZtZUlEZbn/oI1wkt0eIQViTS3aMmev/aSvAKPSIGZVMW3C75hkPLtZqDZHWPrhFrswCwAi3X8=@vger.kernel.org
X-Gm-Message-State: AFuF++lQ2zCovTwV0PG+s1qXWfVmxKq3laO9pYw377T9CrCPgjQZqGx1
	a/VnpMHXuBKiln7ogAyUB0nwjXU3X29S2mGDyaFh+CZgc/QEdWV15+iIr9uH+Pu4OWLZOuSmFxV
	Udz95LbfO6NGcmvIxV9TTXypNOdoM3bkPiZR3YfR2f04Z4uLpwYuRPBpIsByeu1ehPwqX/AmCRg
	==
X-Gm-Gg: AR+sD12s0GvSiQRsu/sIkIaSZNPP7a+LD/mHpatY7x/Rn7qQ+oYcfXN5Zmrp8EPNbZg
	Qmj5M/IeEfPguLCXHyHt7zba3KzHH/VYQWi7WbQz79wmrtvpcR4E5RbpoRXroUCVokO+NrBDIB3
	yzszmWqn6FYqNFJFgZmXXtREGNQrzPOxVtPcebw0uo27uXPzNvhWqNsot5H1QaZdS4/bF0Idzg3
	PGho+wGrn/uEoHq54uYTdz+kOyqiNerEs/YID8+zDeIBoh5ZFiUtilWqSkTwWpsnrOrivem2BcU
	vmqUOXLI1cIZIyDqBwZTnDiX68ZCaAT8v5DSmebN/G6CipqrFVSDuzH/KUSESJUwuTmAjR+uvee
	4txmkxXv0GVbTS4J/9uCGjMZ6mM2V2jrS
X-Received: by 2002:a05:620a:3622:b0:937:4524:68d7 with SMTP id af79cd13be357-937803e1d93mr868630985a.22.1787779172221;
        Wed, 26 Aug 2026 14:19:32 -0700 (PDT)
X-Received: by 2002:a05:620a:3622:b0:937:4524:68d7 with SMTP id af79cd13be357-937803e1d93mr868626985a.22.1787779171607;
        Wed, 26 Aug 2026 14:19:31 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:cc01:6890:c623:cd89:345e:99f3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9377e36879asm301819285a.17.2026.08.26.14.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 14:19:30 -0700 (PDT)
Message-ID: <588ce7912915573ccba7439d7e50a90d7941c764.camel@redhat.com>
Subject: Re: [PATCH 1/4] tracing/osnoise: Per-cpu mutex and fd detachment
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>, sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, linux-trace-kernel@vger.kernel.org
Date: Wed, 26 Aug 2026 16:19:29 -0500
In-Reply-To: <20260826153132.1333fac6@gandalf.local.home>
References: <20260824211544.3984835-1-crwood@redhat.com>
		<20260824211544.3984835-2-crwood@redhat.com>
		<20260824213037.F41B11F000E9@smtp.kernel.org>
	 <20260826153132.1333fac6@gandalf.local.home>
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1cVqznX6xYp4ay7hbQ5PClnspPPPZLaReyoJhSgHUeY_1787779172
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-08-26 at 15:31 -0400, Steven Rostedt wrote:
> On Mon, 24 Aug 2026 21:30:37 +0000
> sashiko-bot@kernel.org wrote:
>=20
> > [Severity: High]
> > Can holding osn_var->lock while calling kthread_stop() cause a deadlock=
?
> >=20
> > kthread_stop() blocks waiting for the target kthread to exit. However, =
if
> > the kthread is currently handling a migration request in
> > osnoise_migration_pending() (shown slightly earlier in the diff), it wi=
ll
> > attempt to acquire this same osn_var->lock before it can clear its stat=
e and
> > exit:
>=20
> This code has a lot of nastiness in the locking with regard to the thread=
.
> I haven't looked deeply at your patch, but the fact that Sashiko pointed
> out a possible deadlock I think you may be hitting the mess I was hitting=
.
>=20
> Have you looked at this thread: https://lore.kernel.org/all/2024082013000=
1.124768-1-tglozar@redhat.com/

That thread is about user fd sync, which is what this patch is trying to
address.

This particular deadlock is with kernel threads, in a corner case of
getting migrated even though we try to pin them to one cpu.  We can get
rid of this migration code and just have stop_kthread() take care of it,
adding a get/put_task_struct() so that it's OK for the thread to die
early.  This way we can also handle any other abnormal thread exits.

I'll respond to the rest of the Sashiko comments soon.

>=20
> It has some tests I ran along with tracing that detected issues. Of cours=
e,
> everything needs to be run with lockdep enabled too.

I did run with lockdep (and some custom hacky state tracking) but
forcing migration is a hole in my test coverage.

Is there a particular test you're suggesting?

-Crystal

