Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892C63B8922
	for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Sep 2026 08:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066901; cv=none; b=lVxJlb25eWW+n5U7gJ/WrOOzZcoc22tVfEthrvnosu4eJerzNV2GdGsak2XuzbngkHLgWfgFldgSWq4vTqkIG7Foelacdrc8s452cKGxNPRrfI/K40xCwbjRlyHkMuVz/nxFvKvmkbfoPcP8gCQ9VLLeBTvPFnxIfXZjLwiZv18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066901; c=relaxed/simple;
	bh=VZBakhQ7Aj2JiPKfaN5oCx6jUVkiV9ICEFcavXVnBek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MmcNXtD5PmYwztOipd1kpbQqa7y2QkSVXEEXkWFWwzAjqxcD/a1IJYy+IGHyBTalMzDcKniCS9Amo/GTBbM0DoRK0GzZmOfoMiI3Ss3hBJZEed7PM5IHj2TgFEjkjrxMz0ic5x9Q8Gj6Q9a1Csqhx8P9tLk4uy08jkeoRSU9f44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=af-unspec.org; spf=pass smtp.mailfrom=fe-bounces.af-unspec.org; dkim=pass (1024-bit key) header.d=af-unspec.org header.i=@af-unspec.org header.b=YrX9fCMI; arc=none smtp.client-ip=121.127.44.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=af-unspec.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.af-unspec.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=af-unspec.org header.i=@af-unspec.org header.b="YrX9fCMI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=af-unspec.org;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-401a4ef265; t=1790066893;
 bh=Ce2HeSUpiklUqBQp4LBNESf9ILV4l4WRtAMGEfQTiuk=;
 b=YrX9fCMIwgCEMf1CHmSvBvlw9WLbBVg5tGgtXRd/UQYTU89HMf3lB/GX962+I5kV/4m5fCcXx
 Pw10ZRTIn4xJT1sBd7DjGGD/zEA+eNA8VYHQTZpRCqLn8ekLcZuwwpK6/W/nhUU80uMANCOcEJ/
 2SPTzr9dPRBr2sJBXHkUias=
X-Forward-Email-ID: 6ab240ca1fd09e956e9b445e
X-Forward-Email-Sender: rfc822; i.maximets@af-unspec.org,
 smtp.forwardemail.net, 121.127.44.66
X-Forward-Email-Version: 2.15.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <6c2a7dae-4517-46d5-9484-06776b69d8f4@af-unspec.org>
Date: Tue, 22 Sep 2026 10:48:04 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] net: dropreason: use new __print_sym() in tracing
To: Antoine Tenart <atenart@kernel.org>, Ilya Maximets <i.maximets@ovn.org>
Cc: Matthieu Baerts <matttbe@kernel.org>,
 Johannes Berg <johannes@sipsolutions.net>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Johannes Berg <johannes.berg@intel.com>, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, dev@openvswitch.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Adrian Moreno <amorenoz@redhat.com>,
 i.maximets@af-unspec.org
References: <20260921101538.97286-6-johannes@sipsolutions.net>
 <20260921101538.97286-9-johannes@sipsolutions.net>
 <98b93c98-21ae-4248-a60a-9625a20508ad@kernel.org>
 <7f557f5a-b21e-45cc-9d3a-cd4f8b5f799b@ovn.org> <arIrrr5Kk-XqnqDz@kwain>
Content-Language: en-US
From: Ilya Maximets <i.maximets@af-unspec.org>
In-Reply-To: <arIrrr5Kk-XqnqDz@kwain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/22/26 9:18 AM, Antoine Tenart wrote:
> On Tue, Sep 22, 2026 at 12:23:55AM +0200, Ilya Maximets wrote:
>> On 9/22/26 12:03 AM, Matthieu Baerts wrote:
>>> Hi Johannes,
>>>
>>> (+Cc openvswitch devs)
>>>
>>> On 21/09/2026 12:06, Johannes Berg wrote:
>>>> From: Johannes Berg <johannes.berg@intel.com>
>>>>
>>>> The __print_symbolic() could only ever print the core
>>>> drop reasons, since that's the way the infrastructure
>>>> works. Now that we have __print_sym() with all the
>>>> advantages mentioned in that commit, convert to that
>>>> and get all the drop reasons from all subsystems. As
>>>> we already have a list of them, that's really easy.
>>>>
>>>> This is a little bit of .text (~100 bytes in my build)
>>>> and saves a lot of .data (~17k).
>>> Thank you for working on that! But it looks like it breaks the
>>> openvswitch test:
>>>
>>> https://netdev-ctrl.bots.linux.dev/logview.html?f=%2Flogs%2Fvmksft%2Fnet%2Fresults%2F833743%2F9-openvswitch-sh%2Fstdout#L168
>>>
>>> Maybe the test needs to be adapted to get the same info differently?
>>> (and adding CONFIG_TRACEPOINTS to the selftest config file)
>> The parsing in the test will definitely need to be updated, i.e.,
>> the numbers swapped with the names of the drop reasons.
>>
>> IIUC, this change only affects the printing and doesn't affect debugging
>> tools like retis that attempt to surface the drop reasons.  But, maybe
>> Adrian and Antoine (CCed) may want to have a glance as well.
> 
> Yes, that's fine.

Ack.  Good to know!
