Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A5C2D8380;
	Wed,  9 Jul 2025 15:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752073714; cv=none; b=Ga70nCJ1hWHJm8wZbh30RTwfolKNtCi2HrooECHnmwqEWUXAwYCjWkor6dcYcDQ5PlKOEV7XdCpfGTUHsIXECLRIWY8U2RBkjQFTHblz8q55JQgrNfvuG7rVRYzgGkLA0YK0qXztcA/1zfnWrRPlUv8Y+6aDb9XZQ7eSic8IsEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752073714; c=relaxed/simple;
	bh=+YrnJroSXCdx+fDrdiaBVBxfnwOU8so60G2bKJ2HRXo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SXSDFwslQsov2mm6RwCzLVRiwQw+cVtaHfX+SxFsnxCMb5Nv6NWjC30jkfYsAQubyO6lIbJ9Q5JCCvL8fwA/4MbHr9xNeuuuWsbCYRWK+qjCiURw92PzeAembRCupRw3UwBMMVQEHS5UaLrfed5GoPqr5egrjK9DUzN4KvmxDJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 3DB0B140570;
	Wed,  9 Jul 2025 15:08:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 41BC72000E;
	Wed,  9 Jul 2025 15:08:28 +0000 (UTC)
Date: Wed, 9 Jul 2025 11:08:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Gabriele Monaco <gmonaco@redhat.com>, John Ogness
 <john.ogness@linutronix.de>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Remove pointless memory barriers
Message-ID: <20250709110827.0dce4012@batman.local.home>
In-Reply-To: <20250708074219.K7BthlGg@linutronix.de>
References: <20250626151940.1756398-1-namcao@linutronix.de>
	<20250626113520.315db641@gandalf.local.home>
	<20250626160459.soHxOROG@linutronix.de>
	<20250626123445.5b01849d@gandalf.local.home>
	<84o6uatn6i.fsf@jogness.linutronix.de>
	<564f10574f11bd7ca42fcc5fb4d6c5625dc17205.camel@redhat.com>
	<20250708074219.K7BthlGg@linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: adga67gho9eapbk1zb6y4tyds8jt4xbc
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 41BC72000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+UGYGwD7G/ehMISPNzeyKG1gcAru3YHmM=
X-HE-Tag: 1752073708-336087
X-HE-Meta: U2FsdGVkX18fLP3zoZqaHRKv/dmgJ+PUBNP7VVDnpIPBTHoHm5m8YZ2+fDs05HWdXMS21LDB5f8e0/T4S358QBc0kBN1XfcniGM5OjC1S2aMEHNNIprHA2ZhRsGcyy23ku9eUDP0zYc/K5CyNPZPYbxqoJJSvT4Qu2Trin3HnauZlno1/ZY+L2o02w/Kh6eSE8gvtziOXY6TJyx/zBZAuxrwv0dP5OUkHk0fbkf3A3ZunnDwirn1Z1TZVI4z22JCKRSGeYKBqBZsYXzLj5mKbqGbZ7NyF060E4/gmtUpgc0lumFFwcITOG4WXPD+f2Xj

On Tue, 8 Jul 2025 09:42:19 +0200
Nam Cao <namcao@linutronix.de> wrote:

> So yes, smp_rmb() is only useful inbetween reads, and smp_wmb() is
> only userful inbetween writes.

Hmm, I wonder if barriers isn't needed but atomic values are?

That is, it looks like rv_monitoring_on() is looking to read the
current state, where as turn_monitoring_on/off() changes the state.

Perhaps instead of barriers, it should use atomics?

 bool rv_monitoring_on(void)
 {
	return atomic_read(&monitoring_on);
 }
 
 static void turn_monitoring_off(void)
 {
	atomic_set(&monitoring_on, 0);
 }
 

Doesn't atomic make sure the values are seen when they are changed?

As this code is more about looking at state and not ordering, and I
think that's what atomics are about.

-- Steve
