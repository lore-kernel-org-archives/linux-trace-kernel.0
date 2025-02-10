Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002C01F55FB;
	Mon, 10 Feb 2025 11:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739188795; cv=none; b=mVuia7U5dbXTnirWtUDijBL0NwA8BVG6+3DOthxZX6JhpbVXmiRfnKvUq1Ke71F4hzHn6DDdiIaux4r+oEqbPEI3ZIWumyapvctKB/x6JbXdnS8bKRJUtQ1W190sRSMfhrVSFeIHOpRFICQAMgqA9beRP5k755+1wkx81sdIGdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739188795; c=relaxed/simple;
	bh=+DJ/KTweca29Jg43dF3lxezvj2t6u/7gKmo1A/LMvvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j5k+eI2bzpCuHZpWB3d7WylUQmWPFd8ipTpPrcwELw7byYGdcabeiQ1uRBlvFmd6F9gg3Y3DE2lOgLdKrX4cEyDkpowhYm/UM2P87FrMKpdIK6QE1L48yIoHS1+7giIorNvHHjGN5+myHI+a7Bo945hYwz7eMXzNiCKL0TDWyyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id C7EF661E647BD;
	Mon, 10 Feb 2025 12:59:42 +0100 (CET)
Message-ID: <b0d55f4c-a078-42a0-a0fe-5823700f2837@molgen.mpg.de>
Date: Mon, 10 Feb 2025 12:59:42 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NOHZ tick-stop error: local softirq work is pending, handler
 #08!!! on Dell XPS 13 9360
To: =?UTF-8?Q?Micha=C5=82_Pecio?= <michal.pecio@gmail.com>
Cc: anna-maria@linutronix.de, frederic@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de
References: <20250210124551.3687ae51@foxbook>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250210124551.3687ae51@foxbook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Michał,


Thank you for your reply.

Am 10.02.25 um 12:45 schrieb Michał Pecio:

>>>>>>>> On Dell XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022, with Linux
>>>>>>>> 6.9-rc2+
> 
>> Just for the record, I am still seeing this with 6.14.0-rc1
> 
> Is this a regression? If so, which versions were not affected?

Unfortunately, I do not know. Right now, my logs go back until September 
2024.

     Sep 22 13:08:04 abreu kernel: Linux version 
6.11.0-07273-g1e7530883cd2 (build@bohemianrhapsody.molgen.mpg.de) (gcc 
(Debian 14.2.0-5) 14.2.0, GNU ld (GNU Binutils for Debian) 2.43.1) #12 
SMP PREEMPT_DYNAMIC Sun Sep 22 09:57:36 CEST 2024

> How hard to reproduce? Wasn't it during resume from hibernation?

It’s not easy to reproduce, and I believe it’s not related with resuming 
from hibernation (which I do not use) or ACPI S3 suspend. I think, I can 
force it more, when having the USB-C adapter with only the network cable 
plugged into it, and then running `sudo powertop --auto-tune`. But 
sometimes it seems unrelated.

> IRQ isuses may be a red herring, this code here is a busy wait under
> spinlock. There are a few of those, they cause various problems.
> 
>                  if (xhci_handshake(&xhci->op_regs->status,
>                                STS_RESTORE, 0, 100 * 1000)) {
>                          xhci_warn(xhci, "WARN: xHC restore state timeout\n");
> 			spin_unlock_irq(&xhci->lock);
>                          return -ETIMEDOUT;
>                  }
> 
> This thing timing out may be close to the root cause of everything.

Interesting. Hopefully the USB folks have an idea.


Kind regards,

Paul


```
$ journalctl -b
[…]
Feb 10 00:23:26 abreu PackageKit[144568]: daemon quit
Feb 10 00:23:26 abreu systemd[1]: packagekit.service: Deactivated 
successfully.
Feb 10 00:25:01 abreu CRON[149822]: pam_unix(cron:session): session 
opened for user root(uid=0) by root(uid=0)
Feb 10 00:25:01 abreu CRON[149824]: (root) CMD (command -v debian-sa1 > 
/dev/null && debian-sa1 1 1)
Feb 10 00:25:01 abreu CRON[149822]: pam_unix(cron:session): session 
closed for user root
Feb 10 00:25:22 abreu gnome-shell[1541]: libinput error: event12 - 
DLL075B:01 06CB:76AF Touchpad: client bug: event processing lagging 
behind by 23ms, your system is too slow
Feb 10 00:25:52 abreu rtkit-daemon[831]: Supervising 9 threads of 6 
processes of 1 users.
Feb 10 00:25:52 abreu rtkit-daemon[831]: Supervising 9 threads of 6 
processes of 1 users.
Feb 10 00:25:57 abreu rtkit-daemon[831]: Supervising 9 threads of 6 
processes of 1 users.
Feb 10 00:25:57 abreu rtkit-daemon[831]: Supervising 9 threads of 6 
processes of 1 users.
Feb 10 00:26:10 abreu rtkit-daemon[831]: Supervising 9 threads of 6 
processes of 1 users.
Feb 10 00:26:10 abreu rtkit-daemon[831]: Supervising 9 threads of 6 
processes of 1 users.
Feb 10 00:26:17 abreu rtkit-daemon[831]: Supervising 9 threads of 6 
processes of 1 users.
Feb 10 00:26:17 abreu rtkit-daemon[831]: Supervising 9 threads of 6 
processes of 1 users.
Feb 10 00:26:18 abreu rtkit-daemon[831]: Supervising 9 threads of 6 
processes of 1 users.
Feb 10 00:26:18 abreu rtkit-daemon[831]: Supervising 9 threads of 6 
processes of 1 users.
Feb 10 00:26:18 abreu rtkit-daemon[831]: Successfully made thread 151021 
of process 137400 owned by '5272' RT at priority 10.
Feb 10 00:26:18 abreu rtkit-daemon[831]: Supervising 10 threads of 7 
processes of 1 users.
Feb 10 00:26:31 abreu kernel: NOHZ tick-stop error: local softirq work 
is pending, handler #08!!!
Feb 10 00:33:04 abreu rtkit-daemon[831]: Supervising 10 threads of 7 
processes of 1 users.
[…]
Feb 10 01:12:37 abreu kernel: PM: suspend entry (deep)
Feb 10 01:12:37 abreu kernel: Filesystems sync: 0.043 seconds
Feb 10 08:06:42 abreu kernel: Freezing user space processes
Feb 10 08:06:42 abreu kernel: Freezing user space processes completed 
(elapsed 0.002 seconds)
[…]
Feb 10 08:11:03 abreu sudo[188932]:  pmenzel : TTY=pts/9 ; 
PWD=/home/pmenzel ; USER=root ; COMMAND=/usr/sbin/powertop --auto-tune
Feb 10 08:11:03 abreu sudo[188932]: pam_unix(sudo:session): session 
opened for user root(uid=0) by pmenzel(uid=5272)
Feb 10 08:11:06 abreu systemd[1355]: Started run-p188949-i188950.scope - 
[systemd-run] /usr/bin/bash.
Feb 10 08:11:09 abreu sudo[188932]: pam_unix(sudo:session): session 
closed for user root
Feb 10 08:12:01 abreu systemd[1355]: run-p188949-i188950.scope: Consumed 
2.080s CPU time, 84.4M memory peak.
Feb 10 08:12:02 abreu systemd[1355]: run-p188220-i188221.scope: Consumed 
44.374s CPU time, 1G memory peak.
Feb 10 08:13:00 abreu kernel: NOHZ tick-stop error: local softirq work 
is pending, handler #08!!!
Feb 10 08:15:01 abreu CRON[189093]: pam_unix(cron:session): session 
opened for user root(uid=0) by root(uid=0)
Feb 10 08:15:01 abreu CRON[189095]: (root) CMD (command -v debian-sa1 > 
/dev/null && debian-sa1 1 1)
Feb 10 08:15:01 abreu CRON[189093]: pam_unix(cron:session): session 
closed for user root
Feb 10 08:15:55 abreu PackageKit[186868]: daemon quit
Feb 10 08:15:55 abreu systemd[1]: packagekit.service: Deactivated 
successfully.
Feb 10 08:15:55 abreu systemd[1]: packagekit.service: Consumed 20.685s 
CPU time, 126.2M memory peak.
Feb 10 08:16:00 abreu kernel: NOHZ tick-stop error: local softirq work 
is pending, handler #08!!!
```
