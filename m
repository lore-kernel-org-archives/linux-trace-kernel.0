Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE5C381AEC;
	Sat,  5 Sep 2026 12:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788612711; cv=none; b=X90w//2WipKo2TzOraBkF+ftOpDEg/9kVgAlkGSu5uXm0Kjs/BaTJdgI+2TVviiusH2ve+iF2YgAL8Wl0/wmtHSbA44fe24OGhIKPXGqiq3vkMQ4obKcUlBYD0GACPxu+UKGjlxGcEUs4OIaTT6iBs4h3KRRrxqpZcNMiqHhFXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788612711; c=relaxed/simple;
	bh=fZBEpl+ftD9+WzMn7LRR2H0PLpgb46A/hgP4wZjNN3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RZTfPdb/FAmTvpx7gNl3e0HSHu1gh9Hv2QbR1yNysGkWDi5jSHsT8494M3AzIFx9lOT7pJEhFowxzFX0f/Noqs7XxL6/wKFv2ulnjdelXfL4jtLMcK/opdh2XsWQgmvnczm/d7RtZkFZaVotiq6NNJWUZwtOegAVhtdM6+ry22M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=BKObiniE; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="BKObiniE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1788612702; x=1789217502; i=w_armin@gmx.de;
	bh=SHV1P6ptG7R+u23V4Ysb03oU0BEe7hpEAnj8gGM0pKY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BKObiniEo5UitAMOSu3QaQsAx+3Kik/xrriU8w2g3COu/UO3pjWd7IiJdTCshJaE
	 +NLvn01TtlabpcS9GV67xFFc/F0kMpaFRQWbYC+Mtlt0avlwvsDz2LE2U1wu7Cc9c
	 YncobMeyPlaVIbFmy1hYAndzOPVF3SdycX8uDmdM3nO6C8RdB382IlKflO9tpMFIS
	 UwuWNx6ZLAM89I6sO/I9GsvClKMX/eSr+v0+uYFthYErMIak/6QydFIZ9sKI66w+4
	 JHFX2jUFudtQk6+w1X+3iFP1PXv66R4axHR8wWwg2pX8VNDjNmzKdNYG4D0somJeN
	 7V08nNg3PeWXylhgXw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfYPi-1wNASE0ZKq-00dntV; Sat, 05
 Sep 2026 14:51:42 +0200
Message-ID: <aa9f7f23-f9b2-4b54-b287-5089caa5b0c9@gmx.de>
Date: Sat, 5 Sep 2026 14:51:36 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Bradley Morgan <brads@mainlining.org>, Aleksandr Nogikh <nogikh@google.com>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-usb@vger.kernel.org,
 driver-core@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
 Johan Hovold <johan@kernel.org>
References: <20260904-bind_taint-v3-0-30025465f38a@linuxfoundation.org>
 <9ac44f3f-1c67-4c37-aa72-255cec1578d2@gmx.de>
 <2026090546-skimming-bundle-0655@gregkh>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <2026090546-skimming-bundle-0655@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:1NWvXrOnyY4yTMWSXL+19xs600GcA51qQobbj7K0JkW6LBBPYb9
 4u7awno/6zhMzp/1HZKbRNne5TbOBj1OpwIeZoHuxKbHNQTTSfY63fOfrjsmu0b4tJH9dqJ
 XTkx71nSpA1z9rqlcXhgNGBZrPJ0Hypb74JlACvwG4kcgM95KJH7DjPAcxN/QVcGMGlbqMR
 YNOlDAmC4DVNAbxj7PJuw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dCtG4xomR7o=;P8RWS2bItmyPlVeLrQxkyu3EZQS
 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

Am 05.09.26 um 13:27 schrieb Greg Kroah-Hartman:

> On Fri, Sep 04, 2026 at 09:46:59PM +0200, Armin Wolf wrote:
>> Am 04.09.26 um 07:10 schrieb Greg Kroah-Hartman:
>>> The ability to add and remove devices from a driver through the sysfs
>>> "bind" and "unbind" files was created all those decades ago as a way
>>> that kernel developers can iterate faster, and provide a debugging way
>>> for users to attempt to add a new device to a driver without having to
>>> rebuild their kernel.
>>>
>>> This api over the years has been abused and recently come under a major
>>> fuzzing "attack" through tools like syzbot which decided that it would
>>> attempt to just randomly bind any driver to any type of device, causing
>>> loads of unneeded errors and pointless kernel patches to be generated by
>>> unsuspecting new developers.
>>>
>>> Handle all of this by adding a new taint flag, TAINT_FORCED_BIND, which
>>> will be set on the driver if the bind/unbind sysfs files are ever
>>> written to.  This lets kernel developers "know" that a user is
>>> attempting to do something that is not normal, and as such, if the
>>> kernel breaks they get to keep the shiny pieces laying around on the
>>> floor.
>>>
>>> The flag is 'Y' which was unused, and can remembered as the user is
>>> "yeeting" the device being operated on here (thrown with force without
>>> regard for the thing being thrown).
>>>
>>> Note, the taint flag gets set _BEFORE_ the bind/unbind callback happens,
>>> as many times crashes/oops/warnings/failures happen within the callback,
>>> and the taint flag needs to be there to show what was being attempted.
>>> If it were to be set after the callback happens, the oops report would
>>> not properly reflect what foolishness was being attempted.
>>>
>>> Fuzzing tools like syzbot, that doesn't have hand-crafted rules to keep
>>> the tool from hitting bind/unbind, should be run with panic_on_taint
>>> enabled so that they fall over and don't continue on, thinking that they
>>> actually found a real issue.
>>>
>>> Userspace operations that rely on the bind/unbind files to work around
>>> the lack of will to upgrade a kernel image to a newer version with
>>> proper support for new devices, or the lack of will to submit valid
>>> device ids to driver authors, will still work properly, but now the
>>> kernel will be flagged in a way that will show that perhaps those users
>>> should reconsider their behavior and work to have the drivers properly
>>> support these devices in a "native" manner.
>> What about users that use driver_override together with vfio-pci? AFAIK
>> they still need to write to bind/unbind.
> As I state above, that is an abuse of this api.
>
>> Also i always liked the fact that the bind/unbind attributes make it very
>> easy in creating generic drivers. In fact, i am intending to use this feature
>> in order to add netlink support to the ACPI-WMI subsystem in the future.
>> I am planning to realize this thru a generic WMI driver that has to be manually
>> bound to a given WMI device to make it available over netlink, so having
>> users be able to write bind/unbind without potentially triggering a kernel panic
>> would be very nice.
> It's a taint flag being set, not a panic, showing developers that "hey,
> the user just did something odd here, ask them about it when handling
> this bug report."
>> Additionally, writing into the bind attribute still checks if the driver and the
>> device match:
>>
>> /*
>>   * Manually attach a device to a driver.
>>   * Note: the driver must want to bind to the device,
>>   * it is not possible to override the driver's id table.
>>   */
>> static ssize_t bind_store(struct device_driver *drv, const char *buf, size_t count)
>>
>> Because of this i would suggest that the taint (if at all) be added to the
>> driver_override attribute instead, because only with this attribute users can bind
>> random drivers to truly random devices.
> I had thought of that, but the force removal of drivers from devices
> wouldn't show up this way, which is one of the things that we do want to
> warn developers about.

IMHO drivers that do not support this should rather just set suppress_bind_attrs.
And drivers for busses that do support hotplugging must support surprise removal
anyway.

Would it be possible to only taint the kernel if the underlying bus does not
claim to be hotplugable?

> And, if we just did the driver_override taint, it would allow those
> drivers who claim to be "generic" like you are referring to, to keep
> "getting away with that" when it's obviously not true that they can
> handle any device for that bus, otherwise it would have automatically
> bound to it already (and no manual intervention would be needed.)
>
> By keeping the manual configuration of bind, you are forcing userspace
> to manually do work, while still a possible thing to do, now at least a
> developer who gets a bug report will _know_ it happened, which is why
> the taint flag is there.
>
> Does that make a bit more sense?

How are users supposed to select between multiple drivers for the same device
if all those drivers claim to support said device? Assuming i have a generic driver
and a more specialized driver that both claim support for the same device. How
can i control which one is ultimately bound to the device without using bind/unbind?
How to utilize driver_override when another driver is already bound to the device
without using the unbind attribute?

Also drivers that claim to be generic while obviously not being able to handle all
devices are themselves broken, not the surrounding mechanism that relies on the data
being supplied by the broken drivers.

Maybe we should instead fix those drivers to stop claiming to be generic? Do you know
the names of some drivers that are affected by this?

Thanks,
Armin Wolf

> thanks,
>
> greg k-h
