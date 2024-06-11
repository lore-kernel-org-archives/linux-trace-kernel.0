Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2719475;
	Tue, 11 Jun 2024 22:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718146386; cv=none; b=QwZn8khqsm7/WtnZEyCzp64hdKk0UxgyVGMZMRd+2lYli/4YmJ32nWxrICswyHpKmgqRCs5/DnA6GATO4M2xStMrha932xhUbuvcwSc2Eq8Z+7oG3BoE+l3LgOnnEzSZlf7WHIlxRpHkswfuh89odf0vLk3PU3adg8OKlDxamMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718146386; c=relaxed/simple;
	bh=fhgz9IAmeJpMQtd4lfMk0iOiZf+Dwg8y0PO7LZ0iNAM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E/OeDK2x7dX90S19+OB6Jlc6JnLavNZ21CXYPGZHbeIJsJyvTNKvxQGoIWp3J4oVzkdQgFAzpqaElkq5anWF912Z6drxH6kxWK2K+k7qrStBT4g9SFh7jvKGrcJyUCNpCospTs4ISRUl06906yRlCFHqS2CjqepaMP/y8J/bFXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200E2C2BD10;
	Tue, 11 Jun 2024 22:53:03 +0000 (UTC)
Date: Tue, 11 Jun 2024 18:53:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Vincent Donnefort <vdonnefort@google.com>,
 Joel Fernandes <joel@joelfernandes.org>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, suleiman@google.com, Thomas Gleixner
 <tglx@linutronix.de>, Vineeth Pillai <vineeth@bitbyteword.org>, Youssef
 Esmat <youssefesmat@google.com>, Beau Belgrave <beaub@linux.microsoft.com>,
 Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>, Borislav
 Petkov <bp@alien8.de>, "Paul E. McKenney" <paulmck@kernel.org>, David
 Howells <dhowells@redhat.com>, Mike Rapoport <rppt@kernel.org>, Dave Hansen
 <dave.hansen@linux.intel.com>, Tony Luck <tony.luck@intel.com>, Ross
 Zwisler <zwisler@google.com>, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v4 01/13] ring-buffer: Allow mapped field to be set
 without mapping
Message-ID: <20240611185319.58a52a1b@gandalf.local.home>
In-Reply-To: <5178e22b-0c00-48d2-8a6e-85510706f145@roeck-us.net>
References: <20240611192828.691638177@goodmis.org>
	<20240611192907.402447387@goodmis.org>
	<5178e22b-0c00-48d2-8a6e-85510706f145@roeck-us.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 15:43:59 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On 6/11/24 12:28, Steven Rostedt wrote:
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > In preparation for having the ring buffer mapped to a dedicated location,
> > which will have the same restrictions as user space memory mapped buffers,
> > allow it to use the "mapped" field of the ring_buffer_per_cpu structure
> > without having the user space meta page mapping.
> > 
> > When this starts using the mapped field, it will need to handle adding a
> > user space mapping (and removing it) from a ring buffer that is using a
> > dedicated memory range.
> > 
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > ---
> >   kernel/trace/ring_buffer.c | 11 ++++++++---
> >   1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index 28853966aa9a..78beaccf9c8c 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -5224,6 +5224,9 @@ static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
> >   {
> >   	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
> >   
> > +	if (!meta)
> > +		return;
> > +
> >   	meta->reader.read = cpu_buffer->reader_page->read;
> >   	meta->reader.id = cpu_buffer->reader_page->id;
> >   	meta->reader.lost_events = cpu_buffer->lost_events;
> > @@ -6167,7 +6170,7 @@ rb_get_mapped_buffer(struct trace_buffer *buffer, int cpu)
> >   
> >   	mutex_lock(&cpu_buffer->mapping_lock);
> >   
> > -	if (!cpu_buffer->mapped) {
> > +	if (!cpu_buffer->mapped || !cpu_buffer->meta_page) {
> >   		mutex_unlock(&cpu_buffer->mapping_lock);
> >   		return ERR_PTR(-ENODEV);
> >   	}
> > @@ -6359,12 +6362,13 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
> >   	 */
> >   	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
> >   	rb_setup_ids_meta_page(cpu_buffer, subbuf_ids);
> > +  
> 
> Picky again. Is that a leftover from something ? I don't see an immediate reason
> for the added newline.

Hmm, I could remove it.

> 
> >   	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
> >   
> >   	err = __rb_map_vma(cpu_buffer, vma);
> >   	if (!err) {
> >   		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
> > -		cpu_buffer->mapped = 1;
> > +		cpu_buffer->mapped++;
> >   		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
> >   	} else {
> >   		kfree(cpu_buffer->subbuf_ids);
> > @@ -6403,7 +6407,8 @@ int ring_buffer_unmap(struct trace_buffer *buffer, int cpu)
> >   	mutex_lock(&buffer->mutex);
> >   	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
> >   
> > -	cpu_buffer->mapped = 0;
> > +	WARN_ON_ONCE(!cpu_buffer->mapped);
> > +	cpu_buffer->mapped--;  
> 
> This will wrap to UINT_MAX if it was 0. Is that intentional ?

If mapped is non zero, it limits what it can do. If it enters here as zero,
we are really in a unknown state, so yeah, wrapping will just keep it
limited. Which is a good thing.

Do you want me to add a comment there?

-- Steve


> 
> >   
> >   	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
> >     

