Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB6015BD
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Jan 2024 05:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoIuR9/M"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-594e894a5eeso1696549eaf.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 01 Jan 2024 21:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704174845; x=1704779645; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=invCKMVVaFy0jJiADuOTq4ZK1FmopzcTk17WVZTa3qA=;
        b=AoIuR9/MbgtAav4g7qwmRDWZG31erwl++L39SR3HkNwOS0z65xRa4bpR9T8TCFLPMs
         e9KZx/DGHfL9vr1Cjqmzk+4DgR3oepXCvBnhhFT+WR97+JWFYd/wBHE0fvhF56Kyumcg
         1U0wkOtecpg27MSnSv2Zhy6iYfuV4Qvp2GDZBn26WNFKqj4QPxWwCanfrzzHGdY/c99t
         e+nn1lfRSs4tymlMCIXTzEMcLMN4loXnWtU98ALekRDd3PGsKIdrFo0JBZdas6Oe3SeZ
         GmV70sIu+3U9mfZxujUxLK+FkM/Ueyb+Wl9n6lUTtFSalZCsI820YeRMwaw8PrYDRQ6N
         y/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704174845; x=1704779645;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=invCKMVVaFy0jJiADuOTq4ZK1FmopzcTk17WVZTa3qA=;
        b=l1d3Sc5xInyuq1LCbScMtJ/gXI+hbKMzbGoQl/L6GIMX5JGih/IxSgSHj4RrnjUd1a
         w4TiF6vsoDF2bDNmZgBAZ2o03ISYljKDOgPWj8XyXGRG+QnOugJrcF1M2xf/bZEZdLqX
         EdfNyvagWjq37n2agsAaYAMXKAEecHkQ2jpvNam/LUroq3yE7oyJoD2XlugvbOILLsFx
         SolOYjYgN9gTcwPbLrexKH9h2/vFIUj3vYHWR9Ms4dFqwkfOExbLpcE1vn5g/9AT9o2g
         stiDBGMJ+eL3TpCVFDDaGtFmnXycq4JRFOrCc0far/6wQVTwyMyepguBLnSKmekYAQg0
         W+bA==
X-Gm-Message-State: AOJu0YxrA7DfgZI0UM8Kpi7EeguI8AmM1o6sYOimfVBVseFRoBjWhSPh
	dHz0b1N1oHtChqFnNVzeQrzQ2xtPXNIOuv5EqLGTAOKpT7I=
X-Google-Smtp-Source: AGHT+IFq+qfnLgvJooOVwJEDsTGpZYSyDl3n3RQCwZnMUHmQBY/iA3qVMYPKCOT5GEobfIOU0j42p3DVzMbYrL2ypUY=
X-Received: by 2002:a4a:a9c1:0:b0:590:97b9:5565 with SMTP id
 h1-20020a4aa9c1000000b0059097b95565mr6134484oon.12.1704174845474; Mon, 01 Jan
 2024 21:54:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: P K <pkopensrc@gmail.com>
Date: Tue, 2 Jan 2024 11:23:54 +0530
Message-ID: <CAL0j0DF-b9ye7TD3mB-BgHvJYCN61NB+QU8Qr25NvfEv0OjPAA@mail.gmail.com>
Subject: Unable to trace nf_nat function using kprobe with latest kernel 6.1.66-1
To: linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I am unable to trace nf_nat functions using kprobe with the latest kernel.
Previously in kernel 6.1.55-1 it was working fine.
Can someone please check if it's broken with the latest commit or  i
have to use it differently?

Mentioned below are output:
Kernel - 6.1.55-1
/ # bpftrace -e 'kprobe:nf_nat_ipv4_manip_pkt { printf("func called\n"); }'
Attaching 1 probe...
cannot attach kprobe, probe entry may not exist
ERROR: Error attaching probe: 'kprobe:nf_nat_ipv4_manip_pkt'



Kernel 6.1.55-1
/ # bpftrace -e 'kprobe:nf_nat_ipv4_manip_pkt { printf("func called\n"); }'
Attaching 1 probe...
func called
func called
