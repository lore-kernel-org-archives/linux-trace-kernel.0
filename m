Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBA51F2C22;
	Thu, 30 Jan 2025 19:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738264043; cv=none; b=ixJkBIm63rEQxIrbse8ZqR0I2bBdq8eiPnE7dxWuZ/bhBIk2eAvMH+uCL4Y5St0VkdBaXw9S2saM7n2cPPhENRnXYE2m07rWkZRGtGpLNTQYQB7rS/WeOqbyqL5FYaC7DkVvIcrYVx5n1sHjA9tLGMPpNXQHQK5njwZyngXEyxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738264043; c=relaxed/simple;
	bh=tlZ6rBd/pJR8Va5NKTLpqW2a7ytzm9msbPe5NDrc5OI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sn0To8zTPsRaADJorvWn5b72I8yW8lfLEwFvOtfYf421M1bsD0TU5aLK0aqiXMZsTwCB97WlhCrrfG5hUkiv7IFZkZf3ui/MAzSfdiQ0ZaAaLzaNUnVRfGVYKjO6c2rV1LR7GSuA+vGjseeT+FQSP8962XdLyHxRdyx3c2OdveA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A71CC4CED2;
	Thu, 30 Jan 2025 19:07:21 +0000 (UTC)
Date: Thu, 30 Jan 2025 14:07:46 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, "Darrick J. Wong" <djwong@kernel.org>,
 Thomas =?UTF-8?B?SGVsbHN0csO2bQ==?= <thomas.hellstrom@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Takashi Iwai <tiwai@suse.de>,
 linux-kernel@vger.kernel.org (open list:TRACING),
 linux-trace-kernel@vger.kernel.org (open list:TRACING)
Subject: Re: [PATCH] irq/tracing: Add IRQ name to irq_handler_exit
 tracepoint
Message-ID: <20250130140746.29cfa7d1@gandalf.local.home>
In-Reply-To: <20250130181439.58130-1-wander@redhat.com>
References: <20250130181439.58130-1-wander@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Jan 2025 15:14:38 -0300
Wander Lairson Costa <wander@redhat.com> wrote:

> The irq_handler_entry tracepoint includes a "name" field, which allows
> for easy identification and filtering of specific IRQs. However, the
> irq_handler_exit tracepoint lacks this field, making it difficult to
> pair corresponding entry and exit events for analysis.
> 
> Add the "name" field to irq_handler_exit to enable consistent tracking
> and correlation of IRQ entry and exit events.

I'm not sure what you mean by this.


# trace-cmd record -e irq_handl* sleep 5
# trace-cmd report

          <idle>-0     [000] d.h1.  4690.628641: irq_handler_entry:    irq=55 name=virtio5-output.0
          <idle>-0     [000] d.h1.  4690.628650: irq_handler_exit:     irq=55 ret=handled
          <idle>-0     [007] d.H1.  4690.628895: irq_handler_entry:    irq=54 name=virtio5-input.0
          <idle>-0     [007] d.H1.  4690.628900: irq_handler_exit:     irq=54 ret=handled
          <idle>-0     [000] d.h1.  4690.802977: irq_handler_entry:    irq=41 name=virtio2-req.0
          <idle>-0     [000] dNh1.  4690.803046: irq_handler_exit:     irq=41 ret=handled
          <idle>-0     [000] d.h1.  4690.813958: irq_handler_entry:    irq=41 name=virtio2-req.0
          <idle>-0     [000] dNh1.  4690.814008: irq_handler_exit:     irq=41 ret=handled
          <idle>-0     [000] d.H1.  4690.814257: irq_handler_entry:    irq=41 name=virtio2-req.0
          <idle>-0     [000] dNH1.  4690.814301: irq_handler_exit:     irq=41 ret=handled
          <idle>-0     [000] d.H1.  4690.815374: irq_handler_entry:    irq=41 name=virtio2-req.0

# cat /proc/interrupts |grep -e 55 -e 54 -e 41
 41:        462          0          0          0          0          0          0          0 PCI-MSIX-0000:04:00.0   1-edge      virtio2-req.0
 54:          0          0          0          0          0          0          0       4539 PCI-MSIX-0000:07:00.0   1-edge      virtio5-input.0
 55:       4544          0          0          0          0          0          0          0 PCI-MSIX-0000:07:00.0   2-edge      virtio5-output.0
RES:       1293       1411       1357       1307       1343       1345       1330       1315   Rescheduling interrupts

We have the names right there. Heck, I could probably write a plugin for
trace-cmd to record the interrupt names in the trace.dat file and print
them out with the events. Any analysis tool could also record that.

That's better than wasting ring buffer space for every event.

-- Steve
