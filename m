Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7091126B09A;
	Wed, 20 Aug 2025 20:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755720260; cv=none; b=gjzT77qlglwdME5lHBgmKni7opMIpEEKSDSePJvGRojpbJM7bePYBLgmaN2C2xqzH3LuCiNITY5qJoKxmjPWmfob4JhRyHPqBN04HUIrLuIpzQ/43zpij5zyLq6DlUDN7Ry3j+1+jsbfClXrxic5egYXCxEJR99Q6hJjwqBTLt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755720260; c=relaxed/simple;
	bh=5sa/xNRb17kRPoZ3g/Vj3okHxMJhho63Z/Z10yyOijU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hz7sC5CIWKDBSffGdS7cEuny06yw5j3CXW6oxI66hE9A9xoOP1a4mbaYHGqFByDm9+25t21txwBOR64wB9rFaLDLi5OO+Cv4ltxOkhfgwxUma7rPMAWeFM+KwuRHhucdTfgzgCWv46OJpRkrUXEJ0kJ4cD9iJxn4TFEejYJC7LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QYp5QdeH; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QYp5QdeH"
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57KK444t3208698;
	Wed, 20 Aug 2025 15:04:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755720244;
	bh=MkmTSU7V12H2RP8eqKNxvOFsCn0iEaIXoplURtUHu9U=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=QYp5QdeHJ5z18pHvYsl9WkgxBXJm1xhOOjE4iAPTM0sGLzM3gx7h+6QRRF04qj5TE
	 SN1hvMCvvyuFNxMCCpFJJ3pwljgdgWN1h8G21qtl6M9T/lBlZ0L4CjKXhh6YF8A6/G
	 ZHk8yXB39IjDB3GEAf1Ph3s9d67DpCgksYApS/dA=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57KK444x1593271
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 20 Aug 2025 15:04:04 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 20
 Aug 2025 15:04:04 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 20 Aug 2025 15:04:03 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57KK43Xm747732;
	Wed, 20 Aug 2025 15:04:03 -0500
Message-ID: <e11fd419-1095-471e-a57f-fc5ff7ce713a@ti.com>
Date: Wed, 20 Aug 2025 15:04:03 -0500
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] PATCH: firmware: ti_sci: Add trace events to TI SCI
To: Jonathan Cormier <jcormier@criticallink.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-trace-kernel@vger.kernel.org>
References: <20250820-linux_master_ti_sci_trace-v1-0-2a69c0abf55e@criticallink.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250820-linux_master_ti_sci_trace-v1-0-2a69c0abf55e@criticallink.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 8/20/25 1:10 PM, Jonathan Cormier wrote:
> Add trace events to help debug and measure the speed of the
> communication channel.
> 
> Add parsing of the messages types but I am not sure how to parse the
> flags, since the REQ and RESP flags conflict. Left as seperate commit to

The REQ and RESP flags should be handled by different TRACE_EVENTs. Right
now you only dump the content of the response messages (the ones in
rx_callback), also tracing what is sent is just as important, so you
might want to add slightly different ti_sci_msg_dump EVENT for the
sending side which uses the different REQ flag parser.

Andrew

> make it easier to drop or make changes depending on comments.  The two
> commits should squash easily.
> 
> Nishanth Menon and Vignesh Raghavendra requested I send this patch
> upstream.
> 
> Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
> ---
> Jonathan Cormier (2):
>        firmware: ti_sci: Add trace events
>        firmware: ti_sci: trace: Decode message types
> 
>   MAINTAINERS                     |   1 +
>   drivers/firmware/Makefile       |   3 +
>   drivers/firmware/ti_sci.c       |  11 +++
>   drivers/firmware/ti_sci_trace.h | 146 ++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 161 insertions(+)
> ---
> base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
> change-id: 20250709-linux_master_ti_sci_trace-91fd2af65dca
> 
> Best regards,

