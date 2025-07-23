Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF002201278;
	Wed, 23 Jul 2025 16:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753289559; cv=none; b=Oa5Ivc//U5VPscqNjtpEhIcpcL1OlInJUdFkAJ9JPZ9JLfaCTC2r9+uVDWnX5LziPnW4+9aWiZXXv6qbz1rISoRFMte7r+INKHvS8qFwDCVdUSmRMrGxNbKNAqPygfiqgohJN9nRUbtjciKwNRdK+cGIv5ShNf6VsJ0BMDJ1+iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753289559; c=relaxed/simple;
	bh=JofbHYmpeTWBte3mEq5zm8ZT/E9qzxhOdLnoSV237tA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lcxobzRozmrjFaYd0dzujlQsaClMN5kQ6oJ5dv5CFz4OBgMQ1aOKMLn6f81/eZSZJyskKgOAM2NCedBjCFI3kloyVRT6HZkqP6CUo7NzRZrOV2Rp4bt/Qv8gQN4ucuTB4X6eQKFJe0aZO1FufBDahLHV3fvCa16RU8kM/5io4mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 8ACC314011D;
	Wed, 23 Jul 2025 16:52:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id A121420028;
	Wed, 23 Jul 2025 16:52:33 +0000 (UTC)
Date: Wed, 23 Jul 2025 12:52:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Takaya Saeki <takayas@google.com>, Tom
 Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] tracing: Have eprobes handle arrays
Message-ID: <20250723125232.15affc52@batman.local.home>
In-Reply-To: <20250723124202.4f7475be@batman.local.home>
References: <20250723124202.4f7475be@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: zdqx4upp3s6haqn1ua1jbwbjp564gbxd
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: A121420028
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX188fSIhx3y/kchu9eoXjgya5cBGYtRQxGA=
X-HE-Tag: 1753289553-692532
X-HE-Meta: U2FsdGVkX18v3xD1TpChQrGVLmC6zCKqedEvXmAYVgzYkLPDT817UjCqWAAFoAaSPKNHskZMkRPaXEX3MIFrk+PVsbkSURE8MBQ1qbVd0L1V9PrXKARndWLcewPeVoDfB6ciOp/NbNcRTZiM1EkSXr7pfqxC83PVvOYMgC+t0uc9yIOdYCxT5wCCX3Vhrdxr9GkaGZVh/ZEZ7z4Kxqs4Mw/naNjwElaTkQGZPf2r5nQ4kwMwW5CVFZTPujdRk9eQKZf1XI/y9lYHuWB/UpeftJAzATDN67KFY7ssAua7Pcu0WQ7zIk1bKE9zQLaV4aPXuGxP7SYxadEY8K5eNM/Sg+LTMfMTH/y8AokI+QytI6Jk9sYsDlkxUyB8BRrkNa9F

On Wed, 23 Jul 2025 12:42:02 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

>  [
>    Create an eprobe called "sys" and attach it to sys_enter.
>    Read the id of the system call and the second argument
>  ]
>  # echo 'e:sys raw_syscalls.sys_enter nr=$id:u32 arg2+8($args):u64' >> /sys/kernel/tracing/dynamic_events

The above has a typo. I originally had it as "filename=+8($args):u64"
but decided to change it to "arg2" as its attached to the generic raw
syscall. But in the process, I accidentally deleted the "=". So the
above should be:

 # echo 'e:sys raw_syscalls.sys_enter nr=$id:u32 arg2=+8($args):u64' >> /sys/kernel/tracing/dynamic_events


> 
>  [
>    Create a synthetic event "path" that will hold the address of the
>    sys_openat filename. This is on a 64bit machine, so make it 64 bits
>  ]
>  # echo 's:path u64 file;' >> /sys/kernel/tracing/dynamic_events
> 
>  [
>    Add a histogram to the eprobe/sys which tiggers if the "nr" field is
>    257 (sys_openat), and save the filename in the "file" variable.
>  ]
>  # echo 'hist:keys=common_pid:file=filename if nr == 257' > /sys/kernel/tracing/events/eprobes/sys/trigger

And I forgot to update this, as it's not "filename" any more, but
"arg2". So this needs to be:

 # echo 'hist:keys=common_pid:file=arg2 if nr == 257' > /sys/kernel/tracing/events/eprobes/sys/trigger

-- Steve
