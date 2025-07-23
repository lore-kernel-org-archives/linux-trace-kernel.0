Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D831F2382;
	Wed, 23 Jul 2025 18:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753295792; cv=none; b=kaGwVk1vPg7XEvNhFjW1oy0n3yDkNA3Nu/ACt6VTu32QQoJxDKzGe+yh5ye+wYDirOCymcBZSN5ujuVuqMRzKQkvixY126VsMVmzp3bDBxa8oIovIBTXJUK+WHQh5wxEfxiiMYj9McBx1VkdEKkWb+DFcw3kk7sUnF10xYIxBSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753295792; c=relaxed/simple;
	bh=yqFMomdPaEK7X3d9xAM+2uDC7w4ugxBVs2gHa1PjSy8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WjHm/oPhh9xy50rFWO+XRJl7ttixHX4gIv8QRYVVLRPHfvKctBPMKTdzUWUxcuJA+m/boUQIoTVnCtxhFYFgspbiFg9sYUGzugaWks5zmeBtXquj3N81wPPym/OZPVZ8tD67DluhSMowHrxiNQYUO1kOTElvJQtluH9l/snurZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id B597B80198;
	Wed, 23 Jul 2025 18:36:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 912772000E;
	Wed, 23 Jul 2025 18:36:26 +0000 (UTC)
Date: Wed, 23 Jul 2025 14:36:25 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Guillaume Nault <gnault@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>, Petr
 Machata <petrm@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] tracing: ipv6: Replace deprecated strcpy()
 with strscpy()
Message-ID: <20250723143625.79ab2c16@batman.local.home>
In-Reply-To: <F998F71D-1244-4154-BC5F-19201C23BDBE@linux.dev>
References: <20250714075436.226197-2-thorsten.blum@linux.dev>
	<20250714123825.6f0485c9@batman.local.home>
	<F998F71D-1244-4154-BC5F-19201C23BDBE@linux.dev>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 97fqo7ua18ip1yyhaw6m5mq7mso11h9i
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 912772000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX186Ou0+sVmKiJAwOSNmliskq3ha9o1Jvlg=
X-HE-Tag: 1753295786-28041
X-HE-Meta: U2FsdGVkX18jsqLw0QVuJ9dT1wLV8GQ269AtzTkLsHIHjm6cdJNrRBG5mG7b2V8smas6y97W/DonII5TkQ+78STxUpxoGndDpxPHOsqHIZ3eai0SHSsjCf2ZuQBb8gPRWE3P0rWiFTVju8AMIUyhpbhIEHmrA/Ub20SJUcaM4sV21Q5cjy3zAnhbAQ2UX2KEXX4mW8yVvWUA7+rE9vBYIpgogh+2A1vPhBxDyyQePLa1kj47RHsvVPGZt2n0qtQ5ZfnDqxcSE/dxQhy0Yfm9D4d0nL7wFV0SMgNcz9XmmvQX63sU5uIGFyomgmZKPwPs

On Wed, 23 Jul 2025 10:46:12 -0700
Thorsten Blum <thorsten.blum@linux.dev> wrote:

> Your commit fca8300f68fe3 changed it from __dynamic_array() to __array()
> and __string() seems to be just a special version of __dynamic_array()
> with a length of -1.
> 
> In the commit description you wrote: "Since the size of the name is at
> most 16 bytes (defined by IFNAMSIZ), it is not worth spending the effort
> to determine the size of the string."

So the original had:

	__dynamic_array(char,  name,   IFNAMSIZ )

Which is not dynamic at all. A dynamic_array (like __string) saves the
size in meta data within the event. So basically the above is wasting
bytes to save a fixed size. If you are going to use a dynamic array,
might as well make it dynamic!

I was doing various clean ups back then so I didn't look too deeply
into this event when I made that change. I just saw the obvious waste
of space in the ring buffer.

Just to explain it in more detail. A dynamic_array has in the ring buffer:

	short offset;
	short len;
	[..]
	char  name[len];

That is, 4 bytes are used to know the size of the array and where in
the event it is located. Thus the __dynamic_array() usage basically had:

	short offset;
	short len = IFNAMSIZ;
	[..]
	char name[IFNAMSIZ];

Why have the offset and length? with just __array(char, name, IFNAMSIZ}
it would be just:

	char name[IFNAMSIZ];

See why I changed it?

Now, the change I'm suggesting now would make the __string() be dynamic!

	short offset;
	short len = strlen(res->nh && res->nh->fib_nh_dev ? res->nh->fib_nh_dev->name : "-") + 1;
	[..]
	char name[len];

As IFNAMSIZ is 16, and the above adds 4 bytes to the name, if the name
is less than 7 bytes or less, you save memory on the ring buffer.

	2 bytes: offset
	2 bytes: len;
	7 bytes + '\0'

total: 12 bytes

Note, if there's only one dynamic value, it is always at least 4 bytes aligned.

-- Steve
