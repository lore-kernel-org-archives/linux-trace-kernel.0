Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939B22F8BEE
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Feb 2026 20:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770321886; cv=none; b=pMPc9O/s1U+Yt9jbK8ufANGuU4wf6ViQUwmpbOEl5bahXcdGaNFzmFnsEHmtOAGmrFjY/JP6/ZVYiUL1VWX1H3X0daOepjPhtIv5fS7tWUDR59htuLZB1tWg7xggUz6uW1sdFGtQege06V3/3m+3YwIpL5+26ZHCW5Nzk3l1LeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770321886; c=relaxed/simple;
	bh=MpzIRiL1wFARKx6US3wamuDmoMcL1a3BV/WSPBMgsf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gfufr0QKu/56fz57HM5+ezkxBLcQxs30W/nW/PXTA4UzCqPKv/VD1FNIPvLsSwQC6QetJXluWyS+mEs7teBolkeUzLRYKjdieN5uz5gpOZ3BOZ4OuGNvdd4Sh7d+AlmMfiPpXpVkLRpdei4hZuxLFWy3WG0EFtc6tKILH2HPpfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X1CTsrd5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X1CTsrd5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770321885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4xKbWRPCaSk2KXAVvogGx97R1hFdOLmVbGXmH5Q5biA=;
	b=X1CTsrd5Qz4Ej/eIWnynDXwt0bX0wfz2LlH0RUmN0xJHsNbJUr70Qd//imEyb7sKMxpSAZ
	q5KHIIj8UD4gEKM52YhADJ5p4r2hyblmB6C5Em/GiRd+zF2gDPxeihO33DVsgV8fH04hsM
	mVFGkjj0d2G4zEm4IphSZnJKTbRBi5I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-466-VZEdgAHPM7G98TNjfWUWTA-1; Thu,
 05 Feb 2026 15:04:44 -0500
X-MC-Unique: VZEdgAHPM7G98TNjfWUWTA-1
X-Mimecast-MFC-AGG-ID: VZEdgAHPM7G98TNjfWUWTA_1770321883
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E5E751955E72;
	Thu,  5 Feb 2026 20:04:42 +0000 (UTC)
Received: from fedora (unknown [10.22.64.136])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3560A19560A7;
	Thu,  5 Feb 2026 20:04:39 +0000 (UTC)
Date: Thu, 5 Feb 2026 17:04:38 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
	"open list:RUNTIME VERIFICATION (RV)" <linux-trace-kernel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 07/20] rv/rvgen: fix typos in automata and generator
 docstring and comments
Message-ID: <aYT3u6EsITYcIysQ@fedora>
References: <20260204144914.104028-1-wander@redhat.com>
 <20260204144914.104028-8-wander@redhat.com>
 <90102c96156337943a5319ab25991f95f9f07cf5.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <90102c96156337943a5319ab25991f95f9f07cf5.camel@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: o3VCTUyyhAKIjGTNMInvVU3DiXm5n-XvCRlHQDTVENY_1770321883
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Feb 05, 2026 at 08:03:16AM +0100, Gabriele Monaco wrote:
> On Wed, 2026-02-04 at 11:42 -0300, Wander Lairson Costa wrote:
> > Fix two typos in the Automata class documentation that have been
> > present since the initial implementation. Fix the class
> > docstring: "part it" instead of "parses it". Additionally, a
> > comment describing transition labels contained the misspelling
> > "lables" instead of "labels".
> > 
> > Fix a typo in the comment describing the insertion of the initial
> > state into the states list: "bein og" should be "beginning of".
> > 
> > Fix typo in the module docstring: "Abtract" should be "Abstract".
> > 
> > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> 
> 
> While you're at it there are a few singular/plural inconsistencies, see below.

Okie dokie. I will update the patch

> 
> Other than that it looks good, thanks!
> 
> Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
> 
> 
> > ---
> >  tools/verification/rvgen/rvgen/automata.py  | 6 +++---
> >  tools/verification/rvgen/rvgen/generator.py | 2 +-
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/verification/rvgen/rvgen/automata.py
> > b/tools/verification/rvgen/rvgen/automata.py
> > index 1feb5f0c0bc3e..0d7cbd0c634a9 100644
> > --- a/tools/verification/rvgen/rvgen/automata.py
> > +++ b/tools/verification/rvgen/rvgen/automata.py
> > @@ -18,7 +18,7 @@ class AutomataError(Exception):
> >      """
> >  
> >  class Automata:
> > -    """Automata class: Reads a dot file and part it as an automata.
> > +    """Automata class: Reads a dot file and parses it as an automata.
> >  
> 
> Automata is plural, the singular is automaton (you can keep the class name
> unchanged): 
> 
> +    """Automata class: Reads a dot file and parses it as an automaton.
> 
> >      Attributes:
> >          dot_file: A dot file with an state_automaton definition.
> > @@ -113,7 +113,7 @@ class Automata:
> >          states = sorted(set(states))
> >          states.remove(initial_state)
> >  
> > -        # Insert the initial state at the bein og the states
> > +        # Insert the initial state at the beginning of the states
> >          states.insert(0, initial_state)
> >  
> >          if not has_final_states:
> > @@ -134,7 +134,7 @@ class Automata:
> >                  line = self.__dot_lines[cursor].split()
> >                  event = line[-2].replace('"','')
> >  
> > -                # when a transition has more than one lables, they are like
> > this
> > +                # when a transition has more than one labels, they are like
> > this
> 
> This should be "more than one label" as singular.
> 
> >                  # "local_irq_enable\nhw_local_irq_enable_n"
> >                  # so split them.
> >  
> > diff --git a/tools/verification/rvgen/rvgen/generator.py
> > b/tools/verification/rvgen/rvgen/generator.py
> > index ee75e111feef1..a3fbb1ac74916 100644
> > --- a/tools/verification/rvgen/rvgen/generator.py
> > +++ b/tools/verification/rvgen/rvgen/generator.py
> > @@ -3,7 +3,7 @@
> >  #
> >  # Copyright (C) 2019-2022 Red Hat, Inc. Daniel Bristot de Oliveira
> > <bristot@kernel.org>
> >  #
> > -# Abtract class for generating kernel runtime verification monitors from
> > specification file
> > +# Abstract class for generating kernel runtime verification monitors from
> > specification file
> >  
> >  import platform
> >  import os
> 

