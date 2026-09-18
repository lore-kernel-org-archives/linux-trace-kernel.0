Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C61B51B17C;
	Fri, 18 Sep 2026 17:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789752630; cv=none; b=U/93TqxUQlPs2bb+L9SWGBjQYJRJ9h6H8uGJLAcDye5l+pMzg1IjFeF1HZD5Z31vBdzxd0O05RLR1ssh0Lo7nV155WlJ4Jm7r6ngn9MBRfMRP+gWhVTMu/U7DSYvfFGDBf+3AHESrDXhHNCn7CUPMW6Pd4ot7JcIz/ax+FxK7Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789752630; c=relaxed/simple;
	bh=1tm+AoINV4L0DvNzsG7gAL49kbFMoxpgRosliSqN+rM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=igg484xKveUt3kuxwcbjk8GkLN5uRhOILVydApPJ+e+ipZE+8QS0gmDxCkR7jc/zMS6Mu1+KfLhCk8HTPxXOYaRBzn79FaHtHWGBAVcvBmCNCAdQCk5hWegenYtc03RBUakiW0NZTLaLpsZIno6RPGmXDu3IUV2ceuU2Ku6DjuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=HDkpRqJZ; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=3XiiCKBo; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="HDkpRqJZ";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="3XiiCKBo"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1789752577; bh=1dl4tmqft2dG4MFdNCM1smn
	Ytjht1tHIKCyecdkRmjI=; b=HDkpRqJZVr8TL8Fkk5XJ1YJQ3JKdWNDF6Dvz6sK7t555pTWVA5
	9+Cm698R50pHkoL9Mg1ZQoSUcHyOij0yBorfNWlLYUFtmEwsf6f4u23zyvuYV3nDtxpNUYLjQ/P
	7kqDUrrm3IgKPoObcgI7KnJdt/wVBWhrEyP2ysCNtT7kXYvE6XAMP/mkhc/UKYzH82PJfO0NFI1
	j3bYCr7pCYuha2nlNCrVh0jfM6o3IbhUoSKFC0zjXdXFLCfE44pO2KNrxDaQuhrGO4o5p2gNkbc
	47sgj7QQxa6B8/gqZatfx3mRX/i435W+dC74xKppg5/FUmNgZZeUPl8H8yOEge5qKxw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1789752577; bh=1dl4tmqft2dG4MFdNCM1smn
	Ytjht1tHIKCyecdkRmjI=; b=3XiiCKBoVXkz5w7h2YTLDkGnQG8EO73zQ+/Fv0ZwZfOhKoim5A
	98WmeNqIRXZ0MA7FUVAIvcxS9vUMB9IHtVDg==;
Date: Fri, 18 Sep 2026 18:29:37 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
CC: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Aleksandr Nogikh <nogikh@google.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-usb@vger.kernel.org, driver-core@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_0/3=5D_driver_co?=
 =?US-ASCII?Q?re=3A_add_TAINT=5FFORCED=5FBIND_fo?=
 =?US-ASCII?Q?r_when_userspace_manually_messes_with_devices_and_drivers?=
In-Reply-To: <2026091850-geriatric-overfull-3370@gregkh>
References: <20260914-bind_taint-v4-0-eadf8a090903@linuxfoundation.org> <DLIL9H50MALI.3JROXYEEUM3KU@kernel.org> <2026091850-geriatric-overfull-3370@gregkh>
Message-ID: <BF545013-EC9D-4939-BBFC-F51B277EEB84@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 18 September 2026 18:25:38 BST, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>On Fri, Sep 18, 2026 at 06:39:02PM +0200, Danilo Krummrich wrote:
>> On Mon Sep 14, 2026 at 4:30 PM CEST, Greg Kroah-Hartman wrote:
>> > The ability to add and remove devices from a driver through the sysfs
>> > "bind" and "unbind" files was created all those decades ago as a way
>> > that kernel developers can iterate faster, and provide a debugging way
>> > for users to attempt to add a new device to a driver without having to
>> > rebuild their kernel.
>> >
>> > This api over the years has been abused and recently come under a
>major
>> > fuzzing "attack" through tools like syzbot which decided that it would
>> > attempt to just randomly bind any driver to any type of device,
>causing
>> > loads of unneeded errors and pointless kernel patches to be generated
>by
>> > unsuspecting new developers.
>> >
>> > Handle all of this by adding a new taint flag, TAINT_FORCED_BIND,
>which
>> > will be set on the driver if the bind/unbind sysfs files are ever
>> > written to.  This lets kernel developers "know" that a user is
>> > attempting to do something that is not normal, and as such, if the
>> > kernel breaks they get to keep the shiny pieces laying around on the
>> > floor.
>> >
>> > The flag is 'Y' which was unused, and can remembered as the user is
>> > "yeeting" the device being operated on here (thrown with force without
>> > regard for the thing being thrown).
>> >
>> > Note, the taint flag gets set _BEFORE_ the bind/unbind callback
>happens,
>> > as many times crashes/oops/warnings/failures happen within the
>callback,
>> > and the taint flag needs to be there to show what was being attempted.
>> > If it were to be set after the callback happens, the oops report would
>> > not properly reflect what foolishness was being attempted.
>> >
>> > Fuzzing tools like syzbot, that doesn't have hand-crafted rules to
>keep
>> > the tool from hitting bind/unbind, should be run with panic_on_taint
>> > enabled so that they fall over and don't continue on, thinking that
>they
>> > actually found a real issue.
>> >
>> > Userspace operations that rely on the bind/unbind files
>> 
>> I agree that this should be avoided.
>> 
>> But I also think the biggest offender really is driver_override.
>Specifically,
>> on a hot-pluggable bus a driver must be complient with the device driver
>> lifecycle rules and hence shouldn't break on bind/unbind. I think it
>would be
>> nice to not taint the kernel for such busses, and only taint on
>driver_override,
>> as I think we'd still want the bug reports for such cases.
>> 
>> But I think this is fine to leave for a follow-up.
>
>Yeah, let's see how this goes, thanks for the review!
>

Famous last words :) 

(I see no regression but AI finds mysteries)

>greg k-h

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
