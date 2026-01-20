Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5F4423A8E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 12:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768910748; cv=none; b=FxdcMXjh63g9bUYHporJxtaRq+7JfoDoW09uzAy3kmZXafrafa/EhQAmz16f1lpJiiLvTDTY0g9gbQ1PTr94/s4USvrZzVjeINqnAyHd67GPhIUjiMk/FTCRI1FcdAJytrTteDKbgnhOkcZZI00iRANMwxOqU8B8RS5AB7tRaiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768910748; c=relaxed/simple;
	bh=4i84Zr5QJmHYBeYGEX++9UTt0UzmWuKcdGfkvw5wjLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEJUZGOAELNF+lwnTkCitntIOWUHKRQLJQU0GVR1UMzTSCtMzZFNqVWaOOl08uuB8jZld17TOKwaB98QCNLkWdqOSOnFNslvfVnLi2YGKEc8lSi3pDDCooYTbF56UXugGRUOWtZTI725mJ1cQ7ll2/i1zn2r6B0X47chmVUgTj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G/HvJGgo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G/HvJGgo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768910745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=crF2Sn134nFLgpNgCxCLXGTh7gt6kUTztOUgmfIrZvY=;
	b=G/HvJGgoA6I4nJb495Yu3jHMHEMHaP9JJoVAWG7gSNnZVIOkYtrFzfoZnDHKFOCQRPDEet
	9QlekG8vEifTv1uMYdi9YVqC3Y+4KtiB5vaQwgTp9nv5qvCWimbLZ8MYh/1PXISN+wZfw/
	BbUquEiUeSzzneQ+Xz6g4QJld9A7UzU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121--YUJEtLENue94KXtPrLLVA-1; Tue,
 20 Jan 2026 07:05:42 -0500
X-MC-Unique: -YUJEtLENue94KXtPrLLVA-1
X-Mimecast-MFC-AGG-ID: -YUJEtLENue94KXtPrLLVA_1768910741
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E43F119560A1;
	Tue, 20 Jan 2026 12:05:40 +0000 (UTC)
Received: from fedora (unknown [10.22.80.33])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4CBC230002DA;
	Tue, 20 Jan 2026 12:05:38 +0000 (UTC)
Date: Tue, 20 Jan 2026 09:05:36 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:RUNTIME VERIFICATION (RV)" <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 14/26] rv/rvgen: remove redundant initial_state removal
Message-ID: <aW9qSrJ_7f9FGeqM@fedora>
References: <20260119205601.105821-1-wander@redhat.com>
 <20260119205601.105821-15-wander@redhat.com>
 <63e032341807f9ece73937d5e20eee9e3162fb61.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63e032341807f9ece73937d5e20eee9e3162fb61.camel@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Jan 20, 2026 at 09:01:01AM +0100, Gabriele Monaco wrote:
> On Mon, 2026-01-19 at 17:45 -0300, Wander Lairson Costa wrote:
> > Remove an unnecessary and incorrect list removal operation in the
> > automata state variable processing. The code attempted to remove
> > initial_state from the states list, but this element was never
> > added to the list in the first place. States with the __init_
> > prefix are explicitly excluded from the states list during the
> > parsing loop, with only the initial_state variable being set
> > from them.
> 
> The initial state is not the state with __init_, but the state pointed to by
> that, the purpose of removing it after sorting and putting it back is for it to
> be the first (we may argue there are better ways to do that, but it works).
> 
> After this change, the initial state is duplicated..
> I think we should just drop this.

Ah, now I understood the reasoning, thanks. I will drop the patch.

> 
> Thanks,
> Gabriele
> 
> > 
> > Calling remove() on an element that does not exist in a list
> > raises a ValueError. This code would have failed during execution
> > when processing any DOT file containing an initial state marker.
> > The subsequent insert operation at index 0 correctly adds the
> > initial_state to the beginning of the states list, making the
> > removal operation both incorrect and redundant.
> > 
> > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> > ---
> >  tools/verification/rvgen/rvgen/automata.py | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/tools/verification/rvgen/rvgen/automata.py
> > b/tools/verification/rvgen/rvgen/automata.py
> > index 7841a6e70bad2..b302af3e5133e 100644
> > --- a/tools/verification/rvgen/rvgen/automata.py
> > +++ b/tools/verification/rvgen/rvgen/automata.py
> > @@ -111,7 +111,6 @@ class Automata:
> >              cursor += 1
> >  
> >          states = sorted(set(states))
> > -        states.remove(initial_state)
> >  
> >          # Insert the initial state at the beginning of the states
> >          states.insert(0, initial_state)
> 

