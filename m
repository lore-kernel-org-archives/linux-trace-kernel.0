Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7BF33C539
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 19:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768937941; cv=none; b=te2uJGJnw+wAYOGwu0Pj5slIZtp5uD+fxsUPw0hPlm9PG4KU95Pq8JwqHWNyJdR6bWfkuRD2WPHskWsPpqbbakbNVGg+53w6bD8ZeFoWWsIrHdj6H3yDSbixSFBeFKDO65Cxc4xWSS228wM4gyjObgBf0pj4rUJuZzgNrbPBtm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768937941; c=relaxed/simple;
	bh=LlYtJ9HbX7kFl0hZHv+RS6OJKckRRjpB//zPWSEhw5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1DeDn6zvu80I+NUMm8EUABk5kJmGXrsvspdyiRJJcrfwyYRq1gYhRAjJy7YlsDkSlRWlSknkr2jncirDEaSuajI4vRc8bkMKYHhWl1wjAUHBxZXMZMTO3YjIZ35m7lZnOOmiPsLgwQyisrG8XHm1wJFr9IjF+7cL6N7W+CBc1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N6n3QjPu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N6n3QjPu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768937937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kU84NdBK6r5DoS96M+oMM901M1iphKQVA9hOUH1SdRQ=;
	b=N6n3QjPuiSBwP0E1LawfuTxlXxB7rlPU+qfBMmDnUIcPUog4Jl7sqsxxrFZtVdsFJEJsvK
	qdcYGCjkEEjTu6uqJZ4CWrELCkSsmHPNkGebi7hirMqDLYan5YcDaKSeLVcP8HwoxPz/3D
	GJ38DMJOBWERIzNWi5tRKhXSQymWzIs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-rO2JM0paOeOS5WqcGGx4Yw-1; Tue,
 20 Jan 2026 14:38:53 -0500
X-MC-Unique: rO2JM0paOeOS5WqcGGx4Yw-1
X-Mimecast-MFC-AGG-ID: rO2JM0paOeOS5WqcGGx4Yw_1768937933
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD44618002C2;
	Tue, 20 Jan 2026 19:38:52 +0000 (UTC)
Received: from fedora (unknown [10.22.80.33])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 36EDB19560AB;
	Tue, 20 Jan 2026 19:38:49 +0000 (UTC)
Date: Tue, 20 Jan 2026 16:38:48 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:RUNTIME VERIFICATION (RV)" <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 17/26] rv/rvgen: fix possibly unbound variable in ltl2k
Message-ID: <aW_Q6ixdtMqnzfhU@fedora>
References: <20260119205601.105821-1-wander@redhat.com>
 <20260119205601.105821-18-wander@redhat.com>
 <b8a2b88e484cac27a82e1c27d0e27599515c4bc6.camel@redhat.com>
 <aW9oj7-iagg2-VF_@fedora>
 <3507c2f454ca66aa27dd3a24e33f5941fac96639.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3507c2f454ca66aa27dd3a24e33f5941fac96639.camel@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Jan 20, 2026 at 01:30:35PM +0100, Gabriele Monaco wrote:
> On Tue, 2026-01-20 at 08:37 -0300, Wander Lairson Costa wrote:
> > On Tue, Jan 20, 2026 at 09:59:11AM +0100, Gabriele Monaco wrote:
> > > On Mon, 2026-01-19 at 17:45 -0300, Wander Lairson Costa wrote:
> > > > Initialize loop variable `i` before the for loop in abbreviate_atoms
> > > > function to fix pyright static type checker error. The previous code
> > > > left `i` potentially unbound in edge cases where the range could be
> > > > empty, though this would not occur in practice since the loop always
> > > > executes at least once with the given range parameters.
> > > > 
> > > > The initialization to zero ensures that `i` has a defined value before
> > > > entering the loop scope, satisfying static analysis requirements
> > > > while preserving the existing logic. The for loop immediately assigns
> > > > i to the first value from the range, so the initialization value is
> > > > never actually used in normal execution paths.
> > > > 
> > > > This change resolves the pyright reportPossiblyUnbound error without
> > > > altering the function's behavior or performance characteristics.
> > > 
> > > So are we just pleasing the tool or is there a real implication of this?
> > > 
> > > Apparently code like
> > > 
> > > for i in range(len([]), -1, -1):
> > >     pass
> > > print(i)
> > > 
> > > works just fine since range() returns at least 0 (as you mentioned in the
> > > commit
> > > message) and i is not used before assignation in the loop, so I don't really
> > > see
> > > a problem.
> > > 
> > > Apparently pyright devs don't want ([1]) to implement a logic to sort out
> > > the
> > > /possibly/ unbound error here.
> > > 
> > > From what I understand, this code is already not pythonic, so rather than
> > > silence the warning to please this tool I'd just refactor the code not to
> > > use i
> > > after the loop (or leave it as it is, since it works fine).
> > > 
> > > What do you think?
> > 
> > You're right, I could have done:
> > 
> > for atom in reversed(atoms): ...
> > 
> 
> I'm missing what you mean with this, the range is iterating over the string
> representation of atom (in reverse) not the array of atoms.
> 

Sorry, I misinterpreted you previous comment and picked the wrong piece
of code.

Yes, the basic goal was to make pyright happy.

> You basically want i to be the length of the longest prefix common to at least
> another atom.
> 
> You could assign i to some python trick doing the exact same thing the loop
> does, like:
> 
>     i = next((i for i in range(len(atom), -1, -1)
>         if sum(a.startswith(atom[:i]) for a in atoms) > 1))
> 
> next() is basically doing the break at the first occurrence from the generator,
> just now your i doesn't live (only) inside the loop.
> 
> So now you save 2 lines and get any C developer scratch their head when they
> look at the code, but hey, pyright is happy!
> 

Or just leave the assignment.

> If you do find the trick with next() readable or have any better idea, feel free
> to try though.
> 

Definitely the next() trick is not worth to make pyright happy.

> Thanks,
> Gabriele
> 
> > I will modify it in v2.
> > 
> > > 
> > > Thanks,
> > > Gabriele
> > > 
> > > [1] - https://github.com/microsoft/pyright/issues/844
> > > 
> > > > 
> > > > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> > > > ---
> > > >  tools/verification/rvgen/rvgen/ltl2k.py | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/tools/verification/rvgen/rvgen/ltl2k.py
> > > > b/tools/verification/rvgen/rvgen/ltl2k.py
> > > > index fa9ea6d597095..94dc64af1716d 100644
> > > > --- a/tools/verification/rvgen/rvgen/ltl2k.py
> > > > +++ b/tools/verification/rvgen/rvgen/ltl2k.py
> > > > @@ -45,6 +45,7 @@ def abbreviate_atoms(atoms: list[str]) -> list[str]:
> > > >  
> > > >      abbrs = []
> > > >      for atom in atoms:
> > > > +        i = 0
> > > >          for i in range(len(atom), -1, -1):
> > > >              if sum(a.startswith(atom[:i]) for a in atoms) > 1:
> > > >                  break
> > > 
> 

