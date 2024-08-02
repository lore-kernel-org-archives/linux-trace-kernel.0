Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C151C37A2
	for <linux-trace-kernel@vger.kernel.org>; Fri,  2 Aug 2024 08:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722588659; cv=none; b=IZvfkPll0BxjauCp+vLG6zKZgPUaAT/FNBpryL0cYoqR7cYD8kBQjV8lLRYJ0+qPjvuIOceuXeT8Iv0VQwMoIIOm6Q3clTGNlNwAJI+muCUNwg6C9sybvOCQ/2ru5H8ZyNVgQQByje+r1GD70HkR9Fh+AsSUu9r9okWNz/aPXkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722588659; c=relaxed/simple;
	bh=HPlsNDCyl1pA4SJW2l3/u62IkAccM0lCQp9d6Y4qNO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCuOdBHXIhURKauxplU+GMYwa7CDtzxYFjzO5VkgSL3SoCgegUuvrl9nmv88IeDdGO76Qe2FwnoBPRrdUPUIL0x5qDebnxs7o0HzpoHFW3kY+ACxI6LXz46COmIYo+BLoB4vuALuG3Uk112Av9yMbHqk7Tzv91SuBflPnf5oM2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HACVXGOV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HACVXGOV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722588656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s5DZo4o3X4z7a84jIBvonPi5Z0Gb8BZSJthltxDUVjw=;
	b=HACVXGOVxYp7VXqzzKQSjI5zn6DsqNFMV1GKNckxuyz10VfkGPyNohZhEi8cIVSSFjaGA8
	Hd++WqahM6m/AuTRmNYFyr5gENdknqKP3o0/5TkM/Vqy0fZ7Rr9//ka7O2araQjBUeDQpg
	kYF5YdEZ5aiEzzJxmpy0lxGrg1r6+1Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-7kBEnFfKMK6GyAT2Jrsglw-1; Fri,
 02 Aug 2024 04:50:50 -0400
X-MC-Unique: 7kBEnFfKMK6GyAT2Jrsglw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5236B19560B4;
	Fri,  2 Aug 2024 08:50:48 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.207])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6362B19560AA;
	Fri,  2 Aug 2024 08:50:44 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  2 Aug 2024 10:50:46 +0200 (CEST)
Date: Fri, 2 Aug 2024 10:50:41 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org, rostedt@goodmis.org, mhiramat@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
	paulmck@kernel.org
Subject: Re: [PATCH 2/8] uprobes: revamp uprobe refcounting and lifetime
 management
Message-ID: <20240802085040.GA12343@redhat.com>
References: <20240731214256.3588718-1-andrii@kernel.org>
 <20240731214256.3588718-3-andrii@kernel.org>
 <CAEf4BzYZ7yudWK2ff4nZr36b1yv-wRcN+7WM9q2S2tGr6cV=rA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYZ7yudWK2ff4nZr36b1yv-wRcN+7WM9q2S2tGr6cV=rA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 08/01, Andrii Nakryiko wrote:
>
> > +               /* TODO : cant unregister? schedule a worker thread */
> > +               WARN(err, "leaking uprobe due to failed unregistration");

> Ok, so now that I added this very loud warning if
> register_for_each_vma(uprobe, NULL) returns error, it turns out it's
> not that unusual for this unregistration to fail.

...

> So, is there something smarter we can do in this case besides leaking
> an uprobe (and note, my changes don't change this behavior)?

Something like schedule_work() which retries register_for_each_vma()...

> I can of course just drop the WARN given it's sort of expected now,

Or least replace it with pr_warn() or uprobe_warn(), WARN() certainly
makes no sense imo...

> I don't
> think that should block optimization work, but just something to keep
> in mind and maybe fix as a follow up.

Agreed, lets do this separately.

Oleg.

