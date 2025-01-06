Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49A11DF732;
	Mon,  6 Jan 2025 18:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736187344; cv=none; b=XB54cLe8DrkDlG8ZosdhGiI0EYiQcwLAUPyXK8kmab7dlusoTCrqPXwpMQQZxPqKwm6q8795Ed+mhksT0JWtpeZd5+eLgEmgErAnAMS8CUiSeJhvcOa+11Ny8r/z2P8s0QlQIPqQqZf6YWYjdudFqfFWboqSXs3OgjvYWJNUY3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736187344; c=relaxed/simple;
	bh=nxQ1nxPl/HqCr//WwtOLjZOYKUVzbdpt5XJdsqqyybQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cAzh8Rmuyn7qkDmrLyr44h4srzFyqNPZ4L5WT+Sn7i2cGM5nmEJyV9kxEBmLALb5eW8kEwzy7lI69ltypTj8l+i28uDA95THrfME8yH8mN8Np5hJYL0lpJq4wCsSoVGL5zhckPgaKgvn7x4dKuaNS4CGslQCGzI9uKbNowXME/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YRj0p3NjWz6K9c2;
	Tue,  7 Jan 2025 02:11:06 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id C701B140A08;
	Tue,  7 Jan 2025 02:15:36 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 6 Jan 2025 19:15:36 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 6 Jan 2025 19:15:36 +0100
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
Thread-Index: AQHbXT3YBSfk6mCs00ebyq2K42O+ArMJ88IAgAASVXA=
Date: Mon, 6 Jan 2025 18:15:36 +0000
Message-ID: <edd0ebb243684fc0a14e8974c8dabf8a@huawei.com>
References: <20250102174317.1594-1-shiju.jose@huawei.com>
 <20250106122204.0f16cb58@gandalf.local.home>
In-Reply-To: <20250106122204.0f16cb58@gandalf.local.home>
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
>Sent: 06 January 2025 17:22
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
>On Thu, 2 Jan 2025 17:43:17 +0000
><shiju.jose@huawei.com> wrote:
>
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> When userspace reads a trace event format file, the maximum data size
>> that can be read is limited to PAGE_SIZE by the seq_read() and
>> seq_read_iter() functions. This results in userspace receiving partial
>> data if the format file is larger than PAGE_SIZE, requiring a
>> workaround to read the complete data from the format file.
>>
>> Add support for reading trace event format files larger than PAGE_SIZE
>> when needed by userspace.
>>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>
>How is this an issue? This is common for all pseudo files and can be handl=
ed
>properly from user space.
>
>Here, with this program:
>
>read.c:
>-------------------------8<-------------------------
>#include <stdlib.h>
>#include <stdio.h>
>#include <unistd.h>
>#include <fcntl.h>
>#include <sys/types.h>
>
>int main (int argc, char **argv)
>{
>	char *buf;
>	int fd;
>	off_t size;
>	int r, s;
>
>	if (argc < 2) {
>		printf("usage: %s file\n", argv[0]);
>		exit(-1);
>	}
>
>	fd =3D open(argv[1], O_RDONLY);
>	if (fd < 0) {
>		perror(argv[1]);
>		exit(-1);
>	}
>
>	size =3D BUFSIZ * 10;
>
>	buf =3D malloc(size);
>	for (s =3D 0, r =3D 1; r > 0; s +=3D r) {
>		r =3D read(fd, buf, size);
>		if (r < 0) {
>			perror(argv[1]);
>			exit(-1);
>		}
>		printf("Read %d bytes from %s\n", r, argv[1]);
>	}
>	free(buf);
>	close(fd);
>	return 0;
>}
>------------------------->8-------------------------
>
> $ read /proc/kallsyms
>Read 4091 bytes from /proc/kallsyms
>Read 4075 bytes from /proc/kallsyms
>Read 4078 bytes from /proc/kallsyms
>Read 4083 bytes from /proc/kallsyms
>Read 4093 bytes from /proc/kallsyms
>Read 4076 bytes from /proc/kallsyms
>Read 4080 bytes from /proc/kallsyms
>Read 4086 bytes from /proc/kallsyms
>Read 4080 bytes from /proc/kallsyms
>Read 4064 bytes from /proc/kallsyms
>Read 4071 bytes from /proc/kallsyms
>Read 4063 bytes from /proc/kallsyms
>Read 4069 bytes from /proc/kallsyms
>Read 4079 bytes from /proc/kallsyms
>Read 4063 bytes from /proc/kallsyms
>Read 4072 bytes from /proc/kallsyms
>Read 4046 bytes from /proc/kallsyms
>Read 4091 bytes from /proc/kallsyms
>Read 4090 bytes from /proc/kallsyms
>Read 4067 bytes from /proc/kallsyms
>Read 4080 bytes from /proc/kallsyms
>Read 4066 bytes from /proc/kallsyms
>Read 4085 bytes from /proc/kallsyms
>Read 4095 bytes from /proc/kallsyms
>Read 4076 bytes from /proc/kallsyms
>Read 4090 bytes from /proc/kallsyms
>Read 4066 bytes from /proc/kallsyms
>Read 4073 bytes from /proc/kallsyms
>Read 4091 bytes from /proc/kallsyms
>Read 4075 bytes from /proc/kallsyms
>Read 4076 bytes from /proc/kallsyms
>Read 4048 bytes from /proc/kallsyms
>Read 4074 bytes from /proc/kallsyms
>Read 4058 bytes from /proc/kallsyms
>Read 4074 bytes from /proc/kallsyms
>[..]
>Read 4052 bytes from /proc/kallsyms
>Read 4061 bytes from /proc/kallsyms
>Read 4061 bytes from /proc/kallsyms
>Read 4053 bytes from /proc/kallsyms
>Read 4083 bytes from /proc/kallsyms
>Read 4066 bytes from /proc/kallsyms
>Read 4093 bytes from /proc/kallsyms
>Read 4072 bytes from /proc/kallsyms
>Read 1982 bytes from /proc/kallsyms
>Read 0 bytes from /proc/kallsyms
>
>You see, it requires multiple reads to pull in an entire kernel pseudo fil=
e. None of
>those reads are greater than PAGE_SIZE. Why should trace format files be a=
ny
>different?
Thanks for the reply.
Yes. I had a fix/workaround in the userspace rasdaemon with multiple reads =
like above
as reported previously in the  following thread. =20
https://lore.kernel.org/lkml/3c9808a694d242cab35bab67602edebf@huawei.com/
However thought a solution in the common kernel code for the format file
may be better.  I will go ahead with the user space solution.
=20
Also shared an information in the above thread about libtraceevent  __parse=
_event() does not
return error when parse_format() fail with incomplete formt data, which res=
ulted initialization for the
trace event does not fail in the user space tool.
>libtracefs handles this perfectly fine:
>
>  https://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git/tree/src/tra=
cefs-
>utils.c#n343
>
>Looks like you are trying to change the kernel to fix a user space bug :-/
>
> NAK!
>
>-- Steve

Thanks,
Shiju
