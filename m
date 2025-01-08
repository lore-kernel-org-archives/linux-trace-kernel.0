Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453DA1F8AD1;
	Wed,  8 Jan 2025 10:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736331575; cv=none; b=lib/mX7tICvV3lkW8Weqxn2ygWwjLgm0M4Zuzx8IxXRKGLgk++1Z/e3AaX+fnU0Ch8RVjhr0T4KdNlAO5td/xJHlfAdg6fjP6Y024qQu9zzDjmGIbjtoTxOU1jLx3+LCbm27Tsr+lOWyDxrGFXvhPyIAlgBi0YswlfWWb2+tr5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736331575; c=relaxed/simple;
	bh=sWYXfmCZ4XKfPYnBm5FJTQdqQ1jGKOZHuykxdaZgkLE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kfp1vEGqpDalGMK4TL0zQTlBWpHua/RoNywhiI0gV3TiqFukLU0cMNuqQLawTYlVknOSGOPUtTPkdhXBrmkm+rraYLUswtZqAYMtq6QToT/nwTMBprwq9h1khZPEonFuW8shIUW0o8y+zQpPi4aa5NuC7R/LZc5PVBdEIZ2xWRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YSkQQ6Db1z67Cxd;
	Wed,  8 Jan 2025 18:18:22 +0800 (CST)
Received: from frapeml100008.china.huawei.com (unknown [7.182.85.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 6D8FF1400D8;
	Wed,  8 Jan 2025 18:19:30 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100008.china.huawei.com (7.182.85.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 8 Jan 2025 11:19:30 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 8 Jan 2025 11:19:30 +0100
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
Thread-Index: AQHbXT3YBSfk6mCs00ebyq2K42O+ArMJ88IAgAASVXCAAD6hAIAA5caAgAC6sACAAMosQA==
Date: Wed, 8 Jan 2025 10:19:30 +0000
Message-ID: <18a64670672d4a368e27cd81fc7b0ae9@huawei.com>
References: <20250102174317.1594-1-shiju.jose@huawei.com>
	<20250106122204.0f16cb58@gandalf.local.home>
	<edd0ebb243684fc0a14e8974c8dabf8a@huawei.com>
	<20250106171150.4d3da6e5@gandalf.local.home>
	<b108b7edec16444ab04da770c796c60c@huawei.com>
 <20250107180224.54c3d3c6@gandalf.local.home>
In-Reply-To: <20250107180224.54c3d3c6@gandalf.local.home>
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
>Sent: 07 January 2025 23:02
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
>On Tue, 7 Jan 2025 11:04:57 +0000
>Shiju Jose <shiju.jose@huawei.com> wrote:
>
>> Please find attached format file, which might have failed to parse
>> because of the unsupported formats in the libtraceevent you mentioned in=
 the
>following thread.
>>
>https://lore.kernel.org/lkml/20241127104132.6c1729e1@gandalf.local.home/#t
>>
>> Please find the improvement in the libraceevent which I mentioned for
>> not returning error when parsing failed,
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> diff --git a/src/event-parse.c b/src/event-parse.c index
>> 0427061..b9264cb 100644
>> --- a/src/event-parse.c
>> +++ b/src/event-parse.c
>> @@ -7905,9 +7905,14 @@ __parse_event(struct tep_handle *tep,
>>               const char *buf, unsigned long size,
>>               const char *sys)
>>  {
>> -       int ret =3D parse_format(eventp, tep, buf, size, sys);
>> -       struct tep_event *event =3D *eventp;
>> +       int ret;
>> +       struct tep_event *event;
>> +
>> +       ret =3D parse_format(eventp, tep, buf, size, sys);
>> +       if (ret)
>> +               return ret;
>>
>> +       event =3D *eventp;
>>         if (event =3D=3D NULL)
>>                 return ret;
>
>Actually, this is the proper patch:
>
>diff --git a/src/event-parse.c b/src/event-parse.c index
>33ed7fb47fff..f2e50b0e8992 100644
>--- a/src/event-parse.c
>+++ b/src/event-parse.c
>@@ -7841,7 +7841,7 @@ static enum tep_errno parse_format(struct tep_event
>**eventp,
> 	ret =3D event_read_format(event);
> 	if (ret < 0) {
> 		ret =3D TEP_ERRNO__READ_FORMAT_FAILED;
>-		goto event_parse_failed;
>+		goto event_alloc_failed;
> 	}
>
> 	/*
>
>
>As it's OK if it returns that it failed to parse the print format, as it c=
an still read
>the event. But if it fails to read the fields, then it is basically useles=
s.=20
Thanks.
Your patch worked fine for returning error to the user space tool for the i=
ncomplete format data case as
the following check become true in the __parse_event()  after freeing 'even=
t' in the goto event_alloc_failed.
 if (event =3D=3D NULL)
     return ret;
>
>-- Steve

Thanks,
Shiju
