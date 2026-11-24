Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795531224;
	b=K1DI+hnIVRiVC02zl8FqKYtgqRIWGwzjcYC7B/Ya2GYqIFMWrVYHkK5FQDc6RcLOv20V
	 uZRg9P0/gAz8Nqs6BnPO8gRywnLMmzXlN/gbIkHizgDsDBHqNvFp+d0poK5eWMBg7Qg0U
	 /6OoHaJtOwk5BWsh0ayj/wsYw5U834qQbhkAkKw4DhPrWls5k3zzVXhFJNz3f/VNHorXm
	 x/Ds87sfNGhf1dIn4O/Mez0bFpQeBo7tt3nQC6aB9hLfGnQevq8/pOkwAzVw9oCpsQGuA
	 680UzLOjOH5Wsmw0VMxcGnBZ9BJKl+j9cQGETYtEDTs2SVQmiSDQJsYIuPXi4ULaO8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795531224;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Spam-Status:
	 X-Rspamd-Server:X-Rspamd-Queue-Id:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=SL3PL1m8jHiSOf5zx037rsGIS1n82PCpE57ofB5Ribc=;
	b=Gn5+tawTj+cH2i2xeJU5s6OkTzzCicJPEB5fe1WofoxkjvyOg5l14ApyPBRivawYIC7e
	 oQRj+YsA10r3Ic6VAOf6cI61YQXLNPYJtmSuKPVZHDYNwyKCyCf2JF5DRYBdnZI5EdAAr
	 MiPXAAwOYjlTElhO/NMT4inZygKOW1mWX1EJjfhCiWG/998LmsLkPl1CEI+FN8usvDjG9
	 w7aN85wPkVacKltjQn/H7rzf2vtqNMM0CnSnBgqKG5Xu7VLq87r8v4pyGx2Q6s1xDsNHY
	 twBZzWjiFqYtSHbkBGeDzUcPvRONWB1xkfIkYeyFrJ4+5xPc8evzonMIhdwNg8mOY2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=lcHe+SfT;
	arc=none smtp.remote-ip=216.40.44.14
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1814F606A31E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 14:40:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1814F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=lcHe+SfT
Received: from omf02.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id BE27B1401F9;
	Tue, 24 Nov 2026 14:40:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 16F3D8000E;
	Tue, 24 Nov 2026 14:40:20 +0000 (UTC)
Date: Tue, 24 Nov 2026 09:40:19 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev, "Linux Trace
 Kernel" <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v7] tracing/probes: Zero out faulted dereferenced fields
Message-ID: <20261124094019.75f52b60@gandalf.local.home>
In-Reply-To: <undine-1795529710371793698-f2bd67810f91497f@undined.local>
References: <20261123213246.00440bfc@gandalf.local.home>
	<sashiko-outbox-230424@kernel.org>
	<20261124090849.7fe8d45f@gandalf.local.home>
	<undine-1795529710371793698-f2bd67810f91497f@undined.local>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 13oqkotsj4gyqyy97c9bjaucspyrhoxo
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 16F3D8000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19p4us7pEBmSioedkxxyrh0wu4Qkrky7W4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=SL3PL1m8jHiSOf5zx037rsGIS1n82PCpE57ofB5Ribc=; b=lcHe+SfT7xaQDB+kGlkAfMmmVDrNIxm/KljeIU9gAnUm2eA7ATIOY+Qwn0+YenE3/oLuOetlIGBnK+Jb2DLyWM7fnO5BMMqeskZboLF3rav9yY/sceLy8d7hEbm1Q7sM6Uy7HtihMu9khfBRhbbWv6b1V5B5/fIxMEQeRWlVd24=
X-HE-Tag: 1795531220-365516
X-HE-Meta: U2FsdGVkX1/ociYjPQuHesWAJ8W79GNT6vIP70TulAk43OTqp9EHZAuziuroqHRx09P0scwr0r1QKb4nX7KV+AG+069B3q4riRoIwiIUhyqCvswgssFvSsdKuefpsfaRU5XkNIevpiIgCuJk+PVpBD8pdDowhAEpAPQIlPybuzB6uKr6YEe7GtdVQOSqoS+Yrt2hI2XKZhnRuivIT1+4cBW2Fx/eF4WHKd/I4Tpew4UtUOHwr6zqxG/uX5IjRG/ynt1c6jfft0VqzZjfcp8H+qdM8tQFZ6SJ3bS3sGpLWnv+2lv0x6C8cNWgXQ939EUtASl63uTzd6JtKprFMDqFXMaexcFpUWsTMFEQqaDJE1CprJqgwjPFEg==

On Tue, 24 Nov 2026 23:15:10 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> > > [Severity: Medium]
> > > Should do_probe_mem_read() and do_probe_mem_read_user() check for a NULL
> > > src before calling probe_mem_read() and probe_mem_read_user()?  
> > 
> > No, but I guess I should add that as we probably shouldn't be dereferencing
> > zero when something fails.  
> 
> Maybe we should make it rejecting dereference if IS_ERR_OR_NULL(ptr).

Do any of these things return ERR? When one of the functions return an
error, the val (or current pointer) gets set to zero. Then that zero
continues to propagate.

The original problem was that if we had multiple dereferences, once one
failed it would exit the loop. If it didn't fail on the final dereference,
it didn't do anything which meant that it left whatever was in the ring
buffer unmodified. This caused the output to show garbage.

The goal here is to set the pointer to NULL as soon as an error is detected
but then let the processing continue. All processing would see the NULL (or
zero) as a fault and continue but would eventually zero out the destination
on the ring buffer.

-- Steve
