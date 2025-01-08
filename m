Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344701F0E33;
	Wed,  8 Jan 2025 10:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736332448; cv=none; b=NYbI4a9+KydtxbZoyTrVd4EfzHtww2Gaan95WFYbsiK0gaKz30EmxoWNRFHmStoi9SzcIxyxRjnNgIPmpvregnVDA0T0YZUmsUiYzVUzyls/ka6AveKIB4IfrEW1QTORbJzENTLj1MoJtemuUawuFUWb8CPoWT4rz4O3SeCOxmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736332448; c=relaxed/simple;
	bh=bP/I4w2X5s2GsdKnfhnVg1IKTv1Wmmiac3NmYPs+D/w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FeEzDnXQ5japHb6MquF+jFuUjqg8VgvxwIv3TfVRqiA5VnTKFOgII1Z2UUfWL6yCfViQu4sD2fRLmM3iAzFTmKvTSo4d5So/YlLvYxrT9ATfk/Y9vgsvtR/bq59VLP6KT4OWaP0itrw3T7X8tDb7sB9Z9gH5V6v0a1EJC4Kb+hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YSkgD2l9sz6JB6k;
	Wed,  8 Jan 2025 18:29:28 +0800 (CST)
Received: from frapeml100006.china.huawei.com (unknown [7.182.85.201])
	by mail.maildlp.com (Postfix) with ESMTPS id 78C93140A34;
	Wed,  8 Jan 2025 18:34:03 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100006.china.huawei.com (7.182.85.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 8 Jan 2025 11:34:03 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 8 Jan 2025 11:34:03 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: "mhiramat@kernel.org" <mhiramat@kernel.org>,
	"mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linuxarm
	<linuxarm@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	tanxiaofei <tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>
Subject: RE: [PATCH 1/1] tracing: Support reading trace event format file
 larger than PAGE_SIZE
Thread-Topic: [PATCH 1/1] tracing: Support reading trace event format file
 larger than PAGE_SIZE
Thread-Index: AQHbXT3YBSfk6mCs00ebyq2K42O+ArMJ88IAgAASVXCAAD6hAIAA5caAgAC6sACAAAS8gIAAyTnA
Date: Wed, 8 Jan 2025 10:34:03 +0000
Message-ID: <cef1ea5d332e4382b26d233c72b8995f@huawei.com>
References: <20250102174317.1594-1-shiju.jose@huawei.com>
	<20250106122204.0f16cb58@gandalf.local.home>
	<edd0ebb243684fc0a14e8974c8dabf8a@huawei.com>
	<20250106171150.4d3da6e5@gandalf.local.home>
	<b108b7edec16444ab04da770c796c60c@huawei.com>
	<20250107180224.54c3d3c6@gandalf.local.home>
 <20250107181921.2ba79257@gandalf.local.home>
In-Reply-To: <20250107181921.2ba79257@gandalf.local.home>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

>-----Original Message-----
>From: Steven Rostedt <rostedt@goodmis.org>
>Sent: 07 January 2025 23:19
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: mhiramat@kernel.org; mathieu.desnoyers@efficios.com; linux-trace-
>kernel@vger.kernel.org; linux-kernel@vger.kernel.org; Linuxarm
><linuxarm@huawei.com>; Jonathan Cameron
><jonathan.cameron@huawei.com>; tanxiaofei <tanxiaofei@huawei.com>;
>Zengtao (B) <prime.zeng@hisilicon.com>
>Subject: Re: [PATCH 1/1] tracing: Support reading trace event format file =
larger
>than PAGE_SIZE
>
>On Tue, 7 Jan 2025 18:02:24 -0500
>Steven Rostedt <rostedt@goodmis.org> wrote:
>
>> diff --git a/src/event-parse.c b/src/event-parse.c index
>> 33ed7fb47fff..f2e50b0e8992 100644
>> --- a/src/event-parse.c
>> +++ b/src/event-parse.c
>> @@ -7841,7 +7841,7 @@ static enum tep_errno parse_format(struct
>tep_event **eventp,
>>  	ret =3D event_read_format(event);
>>  	if (ret < 0) {
>>  		ret =3D TEP_ERRNO__READ_FORMAT_FAILED;
>> -		goto event_parse_failed;
>> +		goto event_alloc_failed;
>>  	}
>>
>>  	/*
>>
>>
>> As it's OK if it returns that it failed to parse the print format, as
>> it can still read the event. But if it fails to read the fields, then
>> it is basically useless.
>
>And the event you posted would still succeed. And it should succeed actual=
ly. It
>just failed to parse the print format. There's a lot of events that do as =
the print
>format is pretty much full C code, and libtraceveent is not a full C parse=
r. It can
>also call functions that it doesn't know about which means even if it were=
 a full C
>parser it would still fail to parse.
>
>But it does flag the event as "TEP_EVENT_FL_FAILED", and should display
>"[FAILED_TO_PARSE]" when printing the generic output.
>
Ok.
>I still think failing to parse the fields is more of a critical error thou=
gh. That
>shouldn't happen, and if it does, it should be corrected.

As reported previously, parsing fields succeed in the rasdaemon for CXL eve=
nts, when format file is larger than
PAGE_SIZE, with the rasdaemon change for reading complete format file.

>
>-- Steve

Thanks,
Shiju
