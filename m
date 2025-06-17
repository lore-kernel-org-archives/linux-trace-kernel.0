Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA30224220
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Jun 2025 21:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750194176; cv=none; b=iQTGvQHkwBhQLtBtFzAaILl6FCO8e3Dbt2QDrR3jDEonB4bzzZDYukg/x1TkJhqvbnTnh1cd6Tt9tqIbSCHqGbPCz+d1aWPvlWAfRAgqQ7pDJGR/0jI5HIdh5NKm6aUv9sC8QnpqNcDjg5iNAXcZJzlKqcRRY3MpVOCC2iO4AN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750194176; c=relaxed/simple;
	bh=u9sQ5FNZIfCRkoh32wY/8yyyp10GkggqKBS9UMhJ8PA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eom11w5xzZqNqYWZDDhlrPz99JOKlLi4pBgehaZRCVTtUtpuBTRPjNu3ArpQlUgFYuxEph15GQ7g6FzLgTGuxuluKpsKZ5Yc1Fhqf4J9EzhT+4FFDX2lx0YBlhzQ6lq3/ZHnPuD70g533HR5NTUGD8oGmydEgH2hA2TbV/ylMlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=sL044JYV; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="sL044JYV"
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HKFjUc000922
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Jun 2025 16:43:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pps01;
 bh=u9sQ5FNZIfCRkoh32wY/8yyyp10GkggqKBS9UMhJ8PA=;
 b=sL044JYV7uef5oYi0VV89Acktqm8ahYTVj+EwwoHVLCTzeBg3FDGb/w9n4QDgQA6tpxa
 BJR1rCPYYivPGmJmLaef4EpEZNXlYf2ljtqx8PBhYGiJet8Wqj2MnqPsQRI4biajggAK
 wQakfJQfmZbRkXLdvZE7P3rwnPLHkFiZpz+rj9UaXrVOvGpVSHolkGCbtIDjntRCoaN5
 0UdSUoMIkoYouigvonAct9ROwkVo4ZH2Xk2nk2ptssdhJg2KC+53E3mYOLdnwvWUTSk5
 TO0bVIZIyfRPOhrSVKa5ZU6Wed98XPF+S+OCrT40JNtaZAWW8hMkCLlhDbDP1PTbkxeQ iA== 
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4794yfjtmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Jun 2025 16:43:55 -0400
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7118199f959so47822707b3.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Jun 2025 13:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750193034; x=1750797834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u9sQ5FNZIfCRkoh32wY/8yyyp10GkggqKBS9UMhJ8PA=;
        b=Ymvc6GN//JHT6bIjrv283eQM6hA/K4xM7G4iagZlKtyle9FYApx61Rxog1KN2SJxnT
         ohQyzukiBPglLEQU8fAtHI7Wymidf6WKmSZIrejrhEYM32DXtAIgtQlvmfFKgUhYV5/3
         lgljulF3lAHIq0lIfbuMXDLw93wzQHOpe6is2hknC7x4X70Leyq+9AzqvWZ0j+WgiWcF
         ppMc957A6onttYlzWkdNz0notPL3AiVrUWGET2AFc/3Mw+TL4sHkjCVElH5NqPweUhIX
         zvgxlzleHrA8q+59+FMOpYR/nlmNSIrz/IpDvHtkst5OvLoxQdIILVLdqD1uV8NGhn3i
         vLBw==
X-Forwarded-Encrypted: i=1; AJvYcCVMJuQk9Qpof21v5B0EX8PfuYxiU4A33Ali0jw5Lmcls2igrCg7kfNHpHpXzeCo7NbJKCSlqL9oQwFc/ItCk/IdYX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFg+oiLOGsqVI4StIhXv3UKyIU1rW+5doQ07vdE6XWfu67wI0X
	4I9e2ebRaIyocMG+tpEUhCfewSdyqUjlXAizC/hCKRHnE4cXxN5M4kIYB+Y+2PbKq7OwjqRUGXr
	TVrBMpUc+SbEImPsYREDpjCo40QK1p9N3ws0jZipgWzKWxdjkERErTr6xlpHz+EcU8a9GJIN28r
	Q+FjX6xD8MAC42/TXA7In01YWzcCJ4pZ6OHBv4m+GjI1RB
X-Gm-Gg: ASbGncvFBLiirkUC5Twpo8gdt8ITduof6TaZY62S57EauNUENFWhnH7YBulDEoeSZMU
	O0hX0yvBCWwYGduAckhBeycKAwkM9kszShruxbyZVF8R0r0++TgHcFCqdOGAhnnjlWqpCpONgGs
	YfGGi7
X-Received: by 2002:a05:690c:6c83:b0:70e:2cba:868c with SMTP id 00721157ae682-71175489fbcmr243794547b3.11.1750193034527;
        Tue, 17 Jun 2025 13:43:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjF0ibehLbKNVTF8HcFuWA6h3KDVMReJtX7DTOphewbVZdmya9vlUAMYxWvtW5I5gCI+10/DiUzzrU1AQ0D2s=
X-Received: by 2002:a05:690c:6c83:b0:70e:2cba:868c with SMTP id
 00721157ae682-71175489fbcmr243794097b3.11.1750193034121; Tue, 17 Jun 2025
 13:43:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528-tlb-trace-fix-v1-0-2e94c58f450d@columbia.edu>
In-Reply-To: <20250528-tlb-trace-fix-v1-0-2e94c58f450d@columbia.edu>
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 17 Jun 2025 16:43:43 -0400
X-Gm-Features: AX0GCFuiCTOK14X6XurXoh82sgBg97ZdwtwT9OBTjyW80sMOJfdncixxOy-kdtk
Message-ID: <CAKha_srZTXfQkizBzvrdpWs6Txw2PSgRAqT6QC8gom=PaitYNg@mail.gmail.com>
Subject: Re: [PATCH 0/2] x86, mm: minor tlb_flush tracepoint adjustments
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: nO3qTJ5V9SbFsc3gfpxBBmGNnNqX8Si0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDE2NSBTYWx0ZWRfXy08YjsNLgn4P rrPAU+lxXksvjChXCpJvrYsG/hiVzsLvlTtmqD9Q1OpLpaGHAFxaBJyAQXw0FNJ4/cQQvcIoe7F ItNZT7oahjzB5gpWjUDKfRzf97cMbu1re6Alh73Bvrg30kiR0yQBE/h9MvxfEBldlTq8HhirAQO
 QZvLEszL5JzhYnfL1+j0eUuGlTZocM9/xZTCX4Ue/i1dYyL7JRvNPkggPFWY8H5Ar+QBHTXQRwE jzQRBqucVOZzINM8RPEZYrq++GSGgL2lij9TtUFKsNpkw3gjFzOhpsi2Pssof8T+1fE3iBrtzzb GH0ogg2D+1cv80FoBQETRymS9jWzD/KR2tNr8plPLOyhK4HtcFdyddO/Cnwe4MVX/wsc/zR1WWD BBoOnb6w
X-Proofpoint-GUID: nO3qTJ5V9SbFsc3gfpxBBmGNnNqX8Si0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_09,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=785 clxscore=1015
 bulkscore=10 phishscore=0 adultscore=0 mlxscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=10 malwarescore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506170165

On Wed, May 28, 2025 at 1:35=E2=80=AFAM Tal Zussman <tz2294@columbia.edu> w=
rote:
>
> One minor fix and one minor cleanup related to the tlb_flush tracepoint.
>
> As an aside, include/trace/events/tlb.h isn't covered by MAINTAINERS,
> along with other mm related files under include/trace/events/. Flagging
> this since I see there's a recent effort to overhaul the mm MAINTAINERS
> entries.
>
> It's been a while since I've submitted patches to the mailing list --
> please let me know if anything looks off. Thanks!

I don't see this series in any of the mm trees -- anything else that needs =
to be
done to get this in?

Thanks,
Tal
