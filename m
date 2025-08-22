Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D5A31DD98;
	Fri, 22 Aug 2025 17:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755884372; cv=none; b=ahCkXDH4bSzP+fOZUuU0T8HpcDRqx0HBrmTA9Y+UAVBZc5k/omr436KQ+0RqeKMB35PcyRRw9CqQ1PHWWSbmAoA4nM2KmZ/kMQpm3A+V2vRNoQVhnzOnBqj9CvJrC6rj//QIxa241b/PCZPl0zI1WPp57fDDpvoXuA51H5HxG4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755884372; c=relaxed/simple;
	bh=oCzH+qVdplQ2pgD+ImK3bjogniiN7B27MVSHwO/I+4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TPbW7zbqkb2ymRfxf0y0PEFkelm9H2qcMk4iTyXT715wX4HcYlMJ1prBvRbEEp1pWKJLycTmCP1l0xywxBvTkgZIXKXndSjFXfG1g8scbLIi2rH/qtyBNv81jWvZ2y/0Pu9expzt+pSPKLT1M1oplLc95u71sSBUw9skkLWCkqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=StjMwzwV; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="StjMwzwV"
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57MHdDTg299741;
	Fri, 22 Aug 2025 12:39:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755884353;
	bh=EQHjqdGHZGwz5jlXpEQ4A8fr2g0aWp9TNlx/qZj0tAM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=StjMwzwVLVDe40mulHlLMB/LS+E0mfIWI6dPqG3qcqRYLkOXRNINtgiW0Yb3khtZP
	 EcV3Mlx1iwu/KMlqC8SK3YRsG6wuS9hAeMjp6raftH98LLC2rP8sRun5DJ1jpfLgR+
	 D1GFZjCuShnGbbCx8PnBcSOJGOjKWpGqis6t5168=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57MHdDpk3077731
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 22 Aug 2025 12:39:13 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 22
 Aug 2025 12:39:12 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 22 Aug 2025 12:39:12 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57MHdCxq3898888;
	Fri, 22 Aug 2025 12:39:12 -0500
Message-ID: <c05c0a13-e7af-4fc0-9363-b629b2c48201@ti.com>
Date: Fri, 22 Aug 2025 12:39:12 -0500
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] PATCH: firmware: ti_sci: Add trace events to TI SCI
To: Jon Cormier <jcormier@criticallink.com>
CC: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh
 Shilimkar <ssantosh@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami
 Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-trace-kernel@vger.kernel.org>
References: <20250820-linux_master_ti_sci_trace-v1-0-2a69c0abf55e@criticallink.com>
 <e11fd419-1095-471e-a57f-fc5ff7ce713a@ti.com>
 <CADL8D3aR_ecr4q54cX7yfr_aDPA7NhXmLhkiHjUY9MjNZeg78Q@mail.gmail.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <CADL8D3aR_ecr4q54cX7yfr_aDPA7NhXmLhkiHjUY9MjNZeg78Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 8/22/25 11:05 AM, Jon Cormier wrote:
> On Wed, Aug 20, 2025 at 4:04 PM Andrew Davis <afd@ti.com> wrote:
>>
>> On 8/20/25 1:10 PM, Jonathan Cormier wrote:
>>> Add trace events to help debug and measure the speed of the
>>> communication channel.
>>>
>>> Add parsing of the messages types but I am not sure how to parse the
>>> flags, since the REQ and RESP flags conflict. Left as seperate commit to
>>
>> The REQ and RESP flags should be handled by different TRACE_EVENTs. Right
>> now you only dump the content of the response messages (the ones in
>> rx_callback), also tracing what is sent is just as important, so you
>> might want to add slightly different ti_sci_msg_dump EVENT for the
>> sending side which uses the different REQ flag parser.
> 
> 
> Does it make sense to have seperate trace events, one that only decode
> the hdrs and ones that also include the buffers?
> 
> I'm bothered by the code duplication, but am trying to convince myself
> it doesn't matter.
> 
> Currently, with the above updates, if you enabled all the traces,
> you'd see something like:
> 
> [15.579036] ti_sci_xfer_begin: type=SET_DEVICE_STATE host=0C seq=00
> flags=00000402 status=0
> [15.xxxxxxx] ti_sci_tx_msg_dump: type=SET_DEVICE_STATE host=0C seq=00
> flags=00000402 data=<data>
> [15.587595] ti_sci_rx_callback: type=SET_DEVICE_STATE host=0C seq=00
> flags=00000002 status=0
> [15.xxxxxxx] ti_sci_rx_msg_dump: type=SET_DEVICE_STATE host=0C seq=00
> flags=00000002 data=<data>
> [15.606135] ti_sci_xfer_end: type=SET_DEVICE_STATE host=0C seq=00
> flags=00000002 status=0
> 
> Presumably if you were worried about timing, you'd disable the
> msg_dumps, avoiding the extra memcpy's.  And if you only cared about
> the data being sent, you'd only enable the msg_dumps.  Does this make
> sense / is it worth the extra trace calls?
> 
> Or removing the buffer decoding in the msg_dumps, removes the duplication:
> 
> [15.579036] ti_sci_xfer_begin: type=SET_DEVICE_STATE host=0C seq=00
> flags=00000402 status=0
> [15.xxxxxxx] ti_sci_msg_dump: data=<data>
> [15.587595] ti_sci_rx_callback: type=SET_DEVICE_STATE host=0C seq=00
> flags=00000002 status=0
> [15.xxxxxxx] ti_sci_msg_dump: data=<data>
> [15.606135] ti_sci_xfer_end: type=SET_DEVICE_STATE host=0C seq=00
> flags=00000002 status=0
> 

I like this one ^^^ but I'd also just remove the `ti_sci_rx_callback`
trace, the contents would always be the same as `ti_sci_xfer_end`.

This way you have two sets of symmetrical trace events, a "begin" and "end"
that can be used for timing measurements, and a dump message for "send" and
"receive" that would help with debugging based on the message contents.

As for the code duplication in the send/receive traces, I'm not sure
what can be done, these trace macros already confuse me enough without
trying to optimize them :)

Andrew

> Or do condense the trace calls so they all have the data into something like:
> 
> [15.579036] ti_sci_xfer_begin: type=SET_DEVICE_STATE host=0C seq=00
> flags=00000402 status=0  data=<data>
> [15.587595] ti_sci_rx_callback: type=SET_DEVICE_STATE host=0C seq=00
> flags=00000002 status=0 data=<data>
> [15.606135] ti_sci_xfer_end: type=SET_DEVICE_STATE host=0C seq=00
> flags=00000002 status=0
> 
> Simplifying the code in the trace header.
>>
>>
>> Andrew
>>
>>> make it easier to drop or make changes depending on comments.  The two
>>> commits should squash easily.
>>>
>>> Nishanth Menon and Vignesh Raghavendra requested I send this patch
>>> upstream.
>>>
>>> Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
>>> ---
>>> Jonathan Cormier (2):
>>>         firmware: ti_sci: Add trace events
>>>         firmware: ti_sci: trace: Decode message types
>>>
>>>    MAINTAINERS                     |   1 +
>>>    drivers/firmware/Makefile       |   3 +
>>>    drivers/firmware/ti_sci.c       |  11 +++
>>>    drivers/firmware/ti_sci_trace.h | 146 ++++++++++++++++++++++++++++++++++++++++
>>>    4 files changed, 161 insertions(+)
>>> ---
>>> base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
>>> change-id: 20250709-linux_master_ti_sci_trace-91fd2af65dca
>>>
>>> Best regards,
>>
> 
> 

