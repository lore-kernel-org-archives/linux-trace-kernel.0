Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181437E0E4
	for <linux-trace-kernel@vger.kernel.org>; Fri, 31 Jan 2025 12:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738325768; cv=none; b=cHzUQdGSgLQC/L2I2fZXpC8aEzDw+bPo7pgGdiuZxnEcdPrhhpHu8GaiBwohqGGW9AJel8CBvzfo0kInI7bxuK+bhOTwbidd7hy4uBpFcsmweyLzudjZWbWI3QHAZ7058tP+Icsl4xbe6OEOmq9bDQL31PNwvici9R+2Ut+wXgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738325768; c=relaxed/simple;
	bh=xVNXGU3BOBz6VovkaATkrxVCp9miVCC0lapSHncvsjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMUCDyFkxrxV2UF0MzwgL4rQW9vAQ332vvPA4od4q31j4cXnN9vNkwpN5ssU9P3hCWpiJ4Uke27vhYcNk2ZEQxp3PFmh4mXI4u2ACjxsl5kfMMRHitRlE8WOgiKNTxQsjANcc4dQHSkC9Fq1UlHX08Ncc80rceihvnWyfhTP4Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IsfrWP2G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IsfrWP2G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738325763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L7K1hH0DEdVK0l8euQ0qaQPd87afRRo3dwkAH+lbwg8=;
	b=IsfrWP2GVdngCX9+0Aefp7V8A1xx7x0kC4JYe9LpalprWj/2ft818G2nWDOrRYd0uw11N/
	yDmpMMFgYhOEY5AYsnha2svARiZpRkUxaYGHFv/r9zrXxBmFat9lKQsBNL2vnDZtCxN5hd
	Sf+IZCRjbo6n9Hk+b9/RZituzBOXlHc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-KfGfnBnkMVGG51wqY1Z9Gg-1; Fri,
 31 Jan 2025 07:16:02 -0500
X-MC-Unique: KfGfnBnkMVGG51wqY1Z9Gg-1
X-Mimecast-MFC-AGG-ID: KfGfnBnkMVGG51wqY1Z9Gg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 978571800366;
	Fri, 31 Jan 2025 12:16:00 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.80.70])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6FAF819560AA;
	Fri, 31 Jan 2025 12:15:55 +0000 (UTC)
Date: Fri, 31 Jan 2025 09:15:54 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Takashi Iwai <tiwai@suse.de>, "open list:TRACING" <linux-kernel@vger.kernel.org>, 
	"open list:TRACING" <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] irq/tracing: Add IRQ name to irq_handler_exit tracepoint
Message-ID: <lg46wfjskaq4pcgjjnn7dqymlvgtdbbzcz4obzfqwymjxh2m7s@dfl7ww4p3rtv>
References: <20250130181439.58130-1-wander@redhat.com>
 <20250130140746.29cfa7d1@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130140746.29cfa7d1@gandalf.local.home>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Thu, Jan 30, 2025 at 02:07:46PM -0500, Steven Rostedt wrote:
> On Thu, 30 Jan 2025 15:14:38 -0300
> Wander Lairson Costa <wander@redhat.com> wrote:
> 
> > The irq_handler_entry tracepoint includes a "name" field, which allows
> > for easy identification and filtering of specific IRQs. However, the
> > irq_handler_exit tracepoint lacks this field, making it difficult to
> > pair corresponding entry and exit events for analysis.
> > 
> > Add the "name" field to irq_handler_exit to enable consistent tracking
> > and correlation of IRQ entry and exit events.
> 
> I'm not sure what you mean by this.
> 

What I meant was looking at the name is easier when you are analysing
several interrupts overlapping on different cores, in special if they
are shared...

> 
> # trace-cmd record -e irq_handl* sleep 5
> # trace-cmd report
> 
>           <idle>-0     [000] d.h1.  4690.628641: irq_handler_entry:    irq=55 name=virtio5-output.0
>           <idle>-0     [000] d.h1.  4690.628650: irq_handler_exit:     irq=55 ret=handled
>           <idle>-0     [007] d.H1.  4690.628895: irq_handler_entry:    irq=54 name=virtio5-input.0
>           <idle>-0     [007] d.H1.  4690.628900: irq_handler_exit:     irq=54 ret=handled
>           <idle>-0     [000] d.h1.  4690.802977: irq_handler_entry:    irq=41 name=virtio2-req.0
>           <idle>-0     [000] dNh1.  4690.803046: irq_handler_exit:     irq=41 ret=handled
>           <idle>-0     [000] d.h1.  4690.813958: irq_handler_entry:    irq=41 name=virtio2-req.0
>           <idle>-0     [000] dNh1.  4690.814008: irq_handler_exit:     irq=41 ret=handled
>           <idle>-0     [000] d.H1.  4690.814257: irq_handler_entry:    irq=41 name=virtio2-req.0
>           <idle>-0     [000] dNH1.  4690.814301: irq_handler_exit:     irq=41 ret=handled
>           <idle>-0     [000] d.H1.  4690.815374: irq_handler_entry:    irq=41 name=virtio2-req.0
> 
> # cat /proc/interrupts |grep -e 55 -e 54 -e 41
>  41:        462          0          0          0          0          0          0          0 PCI-MSIX-0000:04:00.0   1-edge      virtio2-req.0
>  54:          0          0          0          0          0          0          0       4539 PCI-MSIX-0000:07:00.0   1-edge      virtio5-input.0
>  55:       4544          0          0          0          0          0          0          0 PCI-MSIX-0000:07:00.0   2-edge      virtio5-output.0
> RES:       1293       1411       1357       1307       1343       1345       1330       1315   Rescheduling interrupts
> 
> We have the names right there. Heck, I could probably write a plugin for
> trace-cmd to record the interrupt names in the trace.dat file and print
> them out with the events. Any analysis tool could also record that.
> 
> That's better than wasting ring buffer space for every event.
> 

...But you have a point I was not considering before (ring buffer
space).

> -- Steve
> 

