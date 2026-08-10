Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322DD2D2487;
	Mon, 10 Aug 2026 14:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371239; cv=none; b=WEiwWaFWfaAknRu+FzWVU0EUMvbzesYtHh78D1dlts9nU9C3oDl5eefklcv74wgRpRKv6k+NhIgfZiLBBIeCxmR/IvhVhij1CCF/fsLOlg1xlwess+cJignx0xXA1KWvjpZBYySPMpvPb2FRZHMwxVlzhFItO/m4f4NuMICJMrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371239; c=relaxed/simple;
	bh=Di2XSOeqUSjSg9Wf9SAQom3ec9m4O/m2RWJd/mIclHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ekWl4kPt5WunGVAIaW+mhrpwhCo77Gs7mPJTP6fofJX7Sd61n0AbNQsOi9HTBauiOtLnHX/2rA4f3qJN6KQjmnlrBdiBmgbQO+IOCuCVYsQeZXmlxliegitVfNj5TxeYYm3NGOZWjU4mFi9Kz9DIjv7Gm3n09NvL1KmHj1LadcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 0367A1C02AF;
	Mon, 10 Aug 2026 14:13:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 3058C20025;
	Mon, 10 Aug 2026 14:13:48 +0000 (UTC)
Date: Mon, 10 Aug 2026 10:13:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] ring-buffer: Prevent resizing of persistent ring
 buffer
Message-ID: <20260810101357.721f6479@gandalf.local.home>
In-Reply-To: <anmSVUVPVQLPzcaa@google.com>
References: <20260806211306.3704194-1-vdonnefort@google.com>
	<20260806211306.3704194-2-vdonnefort@google.com>
	<20260807111808.d5dc1a48b080d241100f4a57@kernel.org>
	<anWT4heM5Z--A1Mo@google.com>
	<anWosNi-U8lVqBZP@google.com>
	<20260807104526.38430aa2@gandalf.local.home>
	<anX47awNHC9caDN_@google.com>
	<anX9k8x67m4Cdw5n@google.com>
	<20260807152641.4b9deff0@gandalf.local.home>
	<20260810173137.e8c5337fef0f989faed995e4@kernel.org>
	<anmSVUVPVQLPzcaa@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3058C20025
X-Stat-Signature: k6disfdk4de94t61s739dk3xn3aj6ayh
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19cJmmQQbnxU0+I3DKO4o5o3JL2S8GvZCo=
X-HE-Tag: 1786371228-89101
X-HE-Meta: U2FsdGVkX1/mw21ZL4IEg5IaEeV2lgxUOwdAaAar/On/dUSnDJg95DAIzffKsDBtnwbEQsfOfw1oe/iQ3MXPmzSm51rVzw1SOdugBJ5tCB1w/A4sAH8DL9MMqYmufQvCGphik3wJelyzKGLDk993lLT4mD7NdYcMYqIvKtsGSiqBxAXKbUqpNjCxfThL/fdDPanG/nKJdFoxJv9MH5387bDx+TF4zzcuyWaHOEajCEJFXgVWjDn4RmRwXA0soxNTdG2gky3wwYo3bknIHC36wbqilrhTwrfUPQEyLo5r5XAjYQ1/JnIhqjRSalpXe3lcwomQ1gLa+udraxzRCW8lW0WyJGk5Cah/

On Mon, 10 Aug 2026 09:56:53 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> > > 
> > > What would need to be done is:
> > > 
> > >   1. calculate the new size needed to accommodate all the CPU buffers.
> > >   2. Split them up within the new size region.
> > >   3. Then free the remaining pages.
> > > 
> > > Obviously, access to the buffer from readers and writers will need to be
> > > prohibited while this is happening.  
> 
> That would mean losing all the data on the buffer? Actually the trace_remote
> needs to teardown the whole buffer before the size is modified. Perhaps if
> something similar is done for the persistent buffer, trace_remote could benefit.

Yes it would remove all data in the buffer. If you are going to resize the
buffer, you need to be OK with loss of data. It's not going to be a gentle
operation.

> 
> > 
> > Hmm, I think we also need to record the size of persistent ring buffer at
> > initialization. The buffer size (number of pages are calculated by the
> > size of reserved memory, which is defined in the kernel cmdline.  

Oh right. If we do the change, it needs to be stored because of the checks
done at boot up. It checks to make sure that the size on boot up is the
same as when it was running. If we remove pages, that needs to be passed to
the meta data so that on reboot it can detect that.

> 
> Could we store in ring_buffer_cpu_meta::buffers that the page is gone and must
> be skipped to re-create the ring-buffer?

Not just skipped, but the amount "saved" will be different.

Now we need to know that the amount of the ring buffer is different than
the kernel command line. What I would have is this:

1. Bootup wit persistent ring buffer at size X.
2. At run time, shrink buffer to size Y where Y < X
2a. Rewrite buffer with new total size and divvy up the per CPU buffers
2b. Write the new size in the cpu meta data
3. Start tracing
4. Crash/reboot
5. Check meta data checksum, and if match and size is different, divvy up by given size.
5a. Record the currently saved size.
6. Show size as "original cmdline size" (why? see next step)
7. Start tracing
7a.  Rewrite buffer with the origin cmdline size
7b.  Start actual tracing

That is, the resize is only applicable for the boot where the resize
happened. The output of the resize will still be visible, but the buffers
will go back to the original cmdline size as soon as tracing begins again.

If the user resizes again, then jump back to 2a.

The resize is only to allow a user to reclaim persistent buffer memory if
they do not think they need to save as much after boot up.

-- Steve
