Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D34A3D810C;
	Mon, 31 Aug 2026 11:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788177499; cv=none; b=fLTxcPc8H9iCVbryIiNhoWiNsrpfNiOf49WEmG6MYYiCyoLi7HC8vuk+Hi/L+Bfs0GqWMCq/JdCsN4EPk/T+LjaGMEqNOM5Oyq2rbgKun1c4l2e/Pfkeyn4JenH8ZNo2QcEzWsCJS15Mp2yJYj0KPx94RFdy8tbBi+zUScT9Mps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788177499; c=relaxed/simple;
	bh=BZM0zPycUPGlC/MQ4i0mFQQT4axjWRXiEB0nk7replg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=KYYD29nYraQ2cbnCG+ew+YSEhfTyvpvWACplMfoVp8EKlQsJDC0QkZ2QpaPyusv9tcqY9vujG3sEoAR0mFGWWGGVmGgRb0o4jqTddV6IxHKIOKhvdrNhK6NGNbpFOJmPMkEjwKNwo8DktaThekqG2+KG5fbYCJP5DPyGGsB1AA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=TojKNeFL; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=ac1XFzCm; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="TojKNeFL";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="ac1XFzCm"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788177459; bh=gDgWYp6lSGpR6Fw4ej7gEz6
	7vDzTKUrZGtKES2IVKQg=; b=TojKNeFLwNuQE6peaoJwLfn1QfCJKAChrpGKoICfFIdi7DNnq3
	dVEXSHWA9NPUaT4vk+ihaG6QgeF99KKnAgzNAZCeu0pbM1HSTEuMTHsMQOFhODM/QfJa8T4toAI
	OD7EQpPEmlJO2rc/6ou3ZfY34ZXMBOE4lLop0cdszHfcoA0nmsjEUPkemMjMMiBIKGXPaWFHY5S
	HwVlGa8MmIbFyOAHnRzlnlLyw1u0j1IB+qyuVkZopn9TmeonddprA8qOF68VKxloLhFF6DNhXmP
	uHbGZ6I85C8W9uHUwqC80EMrLpeB7U01+eoqMmPNImSshpWh9XVN/Lf2tUqr6CpnCNg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788177459; bh=gDgWYp6lSGpR6Fw4ej7gEz6
	7vDzTKUrZGtKES2IVKQg=; b=ac1XFzCm3bZtmJFVyK3OJH9PpZ3CAQjQolLZ639XEusiSiHMQD
	1GTg+BDw+gi07o+cXflyAPQgZn3WXv4uEDBg==;
Date: Mon, 31 Aug 2026 12:57:40 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Aleksandr Nogikh <nogikh@google.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-usb@vger.kernel.org, driver-core@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_0/2=5D_driver_co?=
 =?US-ASCII?Q?re=3A_add_TAINT=5FFORCED=5FBIND_fo?=
 =?US-ASCII?Q?r_when_userspace_manually_messes_with_devices_and_drivers?=
In-Reply-To: <20260831-bind_taint-v2-0-1082d631213b@linuxfoundation.org>
References: <20260831-bind_taint-v2-0-1082d631213b@linuxfoundation.org>
Message-ID: <9AB1C455-143A-4583-AC25-F6989EADBD6D@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 31 August 2026 11:51:45 BST, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>The ability to add and remove devices from a driver through the sysfs

Hello hello hello!!

Right, this may not be a maintainer preference, but this patch is well
needed, and well beneficial.

Please bare I'm on a well deserved vacation, so I didn't review this super
vigourisly.

Reviewed-by: Bradley Morgan <brads@mainlining.org>


>"bind" and "unbind" files was created all those decades ago as a way
>that kernel developers can iterate faster, and provide a debugging way
>for users to attempt to add a new device to a driver without having to
>rebuild their kernel.
>
>This api over the years has been abused and recently come under a major
>fuzzing "attack" through tools like syzbot which decided that it would
>attempt to just randomly bind any driver to any type of device, causing
>loads of unneeded errors and pointless kernel patches to be generated by
>unsuspecting new developers.
>
>Handle all of this by adding a new taint flag, TAINT_FORCED_BIND, which
>will be set on the driver if the bind/unbind sysfs files are ever
>written to.  This lets kernel developers "know" that a user is
>attempting to do something that is not normal, and as such, if the
>kernel breaks they get to keep the shiny pieces laying around on the
>floor.
>
>The flag is 'Y' which was unused, and can remembered as the user is
>"yeeting" the device being operated on here (thrown with force without
>regard for the thing being thrown).
>
>Note, the taint flag gets set _BEFORE_ the bind/unbind callback happens,
>as many times crashes/oops/warnings/failures happen within the callback,
>and the taint flag needs to be there to show what was being attempted.
>If it were to be set after the callback happens, the oops report would
>not properly reflect what foolishness was being attempted.
>
>Fuzzing tools like syzbot, that doesn't have hand-crafted rules to keep
>the tool from hitting bind/unbind, should be run with panic_on_taint
>enabled so that they fall over and don't continue on, thinking that they
>actually found a real issue.
>
>Userspace operations that rely on the bind/unbind files to work around
>the lack of will to upgrade a kernel image to a newer version with
>proper support for new devices, or the lack of will to submit valid
>device ids to driver authors, will still work properly, but now the
>kernel will be flagged in a way that will show that perhaps those users
>should reconsider their behavior and work to have the drivers properly
>support these devices in a "native" manner.
>
>Finally, the bind/unbind files can find real use-after-free issues with
>some drivers by forcing the process to happen virtually without having
>to rely on manual removal processes.  Those real bugs should still be
>worked on, but by adding this taint flag, developers can more easily
>determine bug reports that are actually worth looking at.
>
>Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>---
>Changes in v2:
>- rebase on 7.3-rc1
>- Add changelog text to describe panic_on_taint and how it should be set
>  for tools like syzbot.
>- Add changelog text to describe why 'Y' was picked.
>- Fixes based on sashiko review:
>  - Make add_taint_module() handle a NULL for module pointer, fixing a
>    problem with built-in drivers.
>  - Fix up prototype for when CONFIG_MODULES is disabled so it will
>    actually build properly.
>  - rst table header fixes.
>- Link to v1: https://patch.msgid.link/20260826-bind_taint-v1-0-52b05f4a965c@linuxfoundation.org
>
>To: Luis Chamberlain <mcgrof@kernel.org>
>To: Petr Pavlu <petr.pavlu@suse.com>
>To: Daniel Gomez <da.gomez@kernel.org>
>To: Sami Tolvanen <samitolvanen@google.com>
>To: Aaron Tomlin <atomlin@atomlin.com>
>To: Jonathan Corbet <corbet@lwn.net>
>To: Shuah Khan <skhan@linuxfoundation.org>
>To: Randy Dunlap <rdunlap@infradead.org>
>To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>To: "Rafael J. Wysocki" <rafael@kernel.org>
>To: Danilo Krummrich <dakr@kernel.org>
>To: Steven Rostedt <rostedt@goodmis.org>
>To: Masami Hiramatsu <mhiramat@kernel.org>
>To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>Cc: linux-modules@vger.kernel.org
>Cc: linux-kernel@vger.kernel.org
>Cc: linux-doc@vger.kernel.org
>Cc: driver-core@lists.linux.dev
>Cc: linux-trace-kernel@vger.kernel.org
>
>---
>Greg Kroah-Hartman (2):
>      module: pull out add_taint_module() to be public
>      driver core: add TAINT_FORCED_BIND for when userspace manually messes with devices and drivers
>
> Documentation/admin-guide/tainted-kernels.rst | 52
> ++++++++++++++-------------
> drivers/base/bus.c                            |  3 ++
> include/linux/module.h                        | 10 ++++++
> include/linux/panic.h                         |  3 +-
> include/trace/events/module.h                 |  3 +-
> kernel/module/main.c                          | 16 +++++++--
> kernel/panic.c                                |  5 +--
> tools/debugging/kernel-chktaint               |  8 +++++
> 8 files changed, 69 insertions(+), 31 deletions(-)
>---
>base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
>change-id: 20260825-bind_taint-d4077b870bc4
>
>Best regards,
>--  
>Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
