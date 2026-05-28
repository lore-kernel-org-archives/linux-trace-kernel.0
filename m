Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC743016E0;
	Thu, 28 May 2026 20:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999704; cv=none; b=FUzXCrjKE8sTsnmL+FV5ZAUuXvAeKCDHjTAIQhTEbVH/znpsVoAgrZhW2euAeCPAFHtt3XO8AktBfDTouyjsvxBWDSCqm0uDfBWTI/AavfFQCFKw77OxeKGbeMl1ADZI1x9s4JCNldF2PKiMbjt2BnruWp0yZSNN66EfGK/NkVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999704; c=relaxed/simple;
	bh=pFpJwmS8Vz8JDbj5K5cjfZbxhTBHd4yghhKke309an8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AFqVEIK1XIZfCVRgKP+amSF397G9TJEkyOf7ms+2wOzb/GMAxFfDTlw0EtueUtMdU2tvLUuVRVEDryCQKqU6T1YkmYkL++U/SujbLPLyjGnHXRiEBWE/FxYqsXOZlc9u6l5V1+EHqne+gFRA84Tu3XbxeVpM7ay4gpLinsJtqTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id B7CA1408E4;
	Thu, 28 May 2026 20:21:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 0C89217;
	Thu, 28 May 2026 20:21:38 +0000 (UTC)
Date: Thu, 28 May 2026 16:22:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Rosen Penev <rosenp@gmail.com>, linux-trace-kernel@vger.kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org (open list:TRACING)
Subject: Re: [PATCHv2] trace: allocate fields with elt struct
Message-ID: <20260528162215.6fb57f30@gandalf.local.home>
In-Reply-To: <20260526134317.394c1cf3060e89df36662ecc@kernel.org>
References: <20260522212627.12406-1-rosenp@gmail.com>
	<20260526134317.394c1cf3060e89df36662ecc@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0C89217
X-Rspamd-Server: rspamout06
X-Stat-Signature: d885qc8x7o86zyyf4h3dtam861nwh9eo
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/G6MpAH8V5EXQFNwaRFpMByEbLqWaL0gE=
X-HE-Tag: 1779999698-808193
X-HE-Meta: U2FsdGVkX1/mzC0zHHxrU8xUSaQOxyUV5V0bjCLX+tob7pztBKnk+OZTHc4IVVkdYOzxreftiu8jwDkzT7TBD8V8WTSl57ACQOLAkkRHp95ZY8h8Jy4BxdHSEFuzCabSDAmvVgzU9Xg5z2rWMT4nYejN218Zlz0W7yS5acJTNjRTsOxWbheM1AUMLgTNXGS3de+pxbQlaHM8NoiLq0nUuTc+ZniPuF+gzOL3Kdb4NU0eknf1zyFC7Bm+9mwKSNC8JxjmskMz1g6SWX3F00uX3HrWtyyFXcA/+zJI6Y3rGxZIvIx0MmkuVKheP3QPlSNSymldu+GksZJrRQ1ledj7/vtl9tukfvCM

On Tue, 26 May 2026 13:43:17 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > >  #define DEFINE_TRACING_MAP_CMP_FN(type)					\
> > > -static int tracing_map_cmp_##type(void *val_a, void *val_b)		\
> > > +static int tracing_map_cmp_##type(const void *val_a, const void *val_b)	\
> > >  {									\
> > > -	type a = (type)(*(u64 *)val_a);					\
> > > -	type b = (type)(*(u64 *)val_b);					\
> > > +	type a = (type)(*(const u64 *)val_a);				\
> > > +	type b = (type)(*(const u64 *)val_b);				\
> > >  									\
> > >  	return (a > b) ? 1 : ((a < b) ? -1 : 0);			\
> > >  }  
> > This is a pre-existing issue, but does unconditionally reading 8 bytes
> > via the u64 cast cause unaligned access exceptions on architectures that
> > do not support them?
> > Additionally, for fields near the end of the dynamically allocated elt->key
> > buffer, can this trigger KASAN slab-out-of-bounds reads?
> > Also, on big-endian architectures, reading a smaller integer as a 64-bit
> > value and casting it down extracts the least-significant bytes rather than
> > the correct field value. Could this result in completely incorrect sorting
> > for small types?  
> 
> Steve, it seems this comes from your commit 106f41f5a302 ("tracing: Have
> the histogram compare functions convert to u64 first").
> 
> I think neither of them is a problem, but could you check it?

This should not be a problem because the pointer being passed in was a
number to begin with. In fact that commit you shared was to fix this
compare on big endian machines. The typecast was specifically made to allow
big endian to work here.

The value is already in a 8 byte (64bit) memory location. It is copied into
it as a 64 bit number. Hence it has to be read as a 64 bit number for the
conversions.

A short would be copied into the location via:

	u64 location;

	location = short_word;

On big endian, for a short word of 0xabcd, it would be in the memory as:

  0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0xab 0xcd

on little endian, it would be:

  0xcd 0xab 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00

For big endian to work, it would need to read that first into a 64 bit word
and then convert it back to short.

Thus, Sashiko doesn't know enough here to comment.

-- Steve
