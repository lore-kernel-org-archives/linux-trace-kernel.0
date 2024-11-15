Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5609188CD8;
	Fri, 15 Nov 2024 15:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684331; cv=none; b=PMS/G3JR9mJxo6v9PaIy3/qlwLQbQUOk7mjwW5EGDmvzrgKQRHnNDgwgjIjDZvqfbwkZjTjl6Liccjl9mt+DBYN/D2JhxEXFJiUp/wmkZ//UEgKbLYnYuxhEIa2hUjBQWD7+YzikKGogfu8EigxpBzNTnUIS1lEDRBE2iPbmjWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684331; c=relaxed/simple;
	bh=5rYKUaf2nEsuTaZGCRM6dgfAzuTpMATrxoffoQ/cwMA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IDS3LVgR85c47/vARXs+8AuwuW5NKhZsStS9MGx5Aq7f29SawvWCBr7iZG/FOj3HOv1wDPm4XvkZhdCVid5h0mVfMRbmVZaJVxCcl469BytFmZn26IItPXmsDTlDFMRrffakb0EWNJDCVSpgL6F6q0OTfsKAcfqOjxHbmTg9M+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3692C4CECF;
	Fri, 15 Nov 2024 15:25:30 +0000 (UTC)
Date: Fri, 15 Nov 2024 10:25:54 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Geert Uytterhoeven
 <geert@linux-m68k.org>, Greg Ungerer <gerg@linux-m68k.org>
Subject: Re: [PATCH RFC 0/2] Add basic tracing support for m68k
Message-ID: <20241115102554.29232d34@gandalf.local.home>
In-Reply-To: <3a8f6faa-62c6-4d32-b544-3fb7c00730d7@yoseli.org>
References: <20241021-add-m68k-tracing-support-v1-0-0883d704525b@yoseli.org>
	<3a8f6faa-62c6-4d32-b544-3fb7c00730d7@yoseli.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Nov 2024 09:26:07 +0100
Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org> wrote:

> Nevertheless it sounds like a really high latency for wake_up().
> 
> I have a custom driver which basically gets an IRQ, and calls wake_up on 
> a read() call. This wake_up() on a high cpu usage can be more than 1ms ! 
> Even with a fifo/99 priority for my kernel thread !
> 
> I don't know if it rings any bell ?
> I can obviously do more tests if it can help getting down to the issue :-).

Try running timerlat.

-- Steve
