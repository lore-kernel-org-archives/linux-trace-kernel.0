Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7131B367B60
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jun 2026 13:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782827985; cv=none; b=uU3uH/GlhTURNW/no8sbe3edUXDu0/u9JK6veo7UsoLijOHafIAJ76KrTlQgtXHmT3TaHXItgvYuz2AJlsfUsOp3UJ1sqwEaCyzpAKngp54/7ey2c0b3xMOUxwcyWFsDi6vNdePE81dveVG00e3wKy9t85Oqj60CJc+P+2uU26w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782827985; c=relaxed/simple;
	bh=7IzouNqHCTxixbaDJLYtKzLpDaeKVkkf4MHxpOG9+TE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z8gPWJYNMUf5CxdNHpltm64B+CFit50sM8GK7Nd0PzieI7XJPPr5koT5WL3HAsQH8cXu/CXgfE2uX4QOI4ohINA1ILok2IaXdKP1m2La/jQJdpdqPUe3K+1BLTUMKvv14F+xMZHmta5PgQRmOz1Hj9No77ChA/M3wwkm/Ttdn2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fx5oziuW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fx5oziuW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782827983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WG+zpGkrLI7Lz/OHTs0Y60PAp7eFtl39yZrdko5cXCQ=;
	b=Fx5oziuWpBgBYlrnviDZwsYCXz+RAUWdQv+VWO5yUZzmja1Oj1MbLswbSD5P/oshQepjIb
	c4HNzT29Vbw3maEpTJolA6gdhTjMrFSrfPlQ0Me6FZ6CU79Pv4DISKSjVR7Y0EPbAFq4zg
	xpKftre8NnQqmiEQeZ1CfsVtZfWLebA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-CEXf86hKNpqLP6Wo0hw6Pw-1; Tue, 30 Jun 2026 09:59:41 -0400
X-MC-Unique: CEXf86hKNpqLP6Wo0hw6Pw-1
X-Mimecast-MFC-AGG-ID: CEXf86hKNpqLP6Wo0hw6Pw_1782827981
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c125bdd01cbso272800966b.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jun 2026 06:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782827981; x=1783432781;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WG+zpGkrLI7Lz/OHTs0Y60PAp7eFtl39yZrdko5cXCQ=;
        b=dY5pamEFIVLpC9UMF161LME3FEqbZpRn6quDum2qQhTbOdPJYizWYLymPw/+JwfMCn
         47kQyA0FPPT10sjw9Ny+9oSTK/NbgcYpFfq8jz/mt9kszQrs/KBdqw6F0xqKADTWaB2p
         /CBc+W4+c19rRV4YAbzhWk7WZ0AXm3sh9jBXEQKQ09j9ZHme6PDcuRUDS72C0+sYCyD6
         jB/GBLvIISV+vbj5LF3/ya7ATHjSPb55EQi/z90vOVg1oW65PhVdGEwLT2KpvcJPQxz3
         sQ1wKfOy+eES41miYVEPcBDws8lRhxqJoSE/U7L7zvFvgLRMeQK+V1PtESk+U2msfKcV
         h8QQ==
X-Forwarded-Encrypted: i=1; AHgh+RoxpptQdAfPFcbTV1Pk0dCtzL1t+rUOBm/xt6mVAIHvC4UM+7G+3d1imkhn1GkQs84rtTTrOtY+q7uqEnPNhJGUQAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrwNnzw2A43UaZOs3KL0PRUPa+zWrRB15GtDSqHGoIWN1OkSG8
	cDqyS4W790QgElJL7uBzx/yuAXif9xmMUk7drJ+H5caMQwHgUeINRMOxJfDIYcah/OjQNuF0D+D
	1UrtfLMChkdNtNeZhaKBsMGCgR7Sh8rJnqG8wmiweJOXHMmJ1SZ94fcHMWoRyFM1+LlkDdxtKhA
	==
X-Gm-Gg: AfdE7cmgc38BWbEJ8QWeANYKrVCiwt2YudatVRW1k3aXcqKmfrjCRvGSLvLFw0PyD4G
	fRKYBZgoxEmpRuNuDJ8o0WkmFes+ir1ouEO9nqErw0FPsoFQ/KHIaH8fNeZEBw6MeDSH/ROY1Sr
	EA1N3GhlA5LQFrAhvWTezHHyyP0Dr2jrVki9LzePQJhfB6xQHFAcnoYuGKnBdW/hD9zPZJH5esO
	I+31tTo8v87XOQo3fE0NQhPgXVP2n6zbGq01fv39Ip6pNH1C7zrpRbcr1JLhZ9g9i5GF/nVS/XV
	HR1BfnX8fZqCU2PazJrDeS/TYHV/ty01OyasDyxpovPJ06T86o7NXtez18Zd4A25yGn8wBasbz9
	DcW2sw6smzzfMO3YB+BSbncxQpx9g6pD5YvoSmm9nYVIpURcMvRC/Q0YaRvwJotO+wY1H7CI1
X-Received: by 2002:a17:907:6d1c:b0:c12:992b:16d4 with SMTP id a640c23a62f3a-c12992b21c0mr27219366b.41.1782827980703;
        Tue, 30 Jun 2026 06:59:40 -0700 (PDT)
X-Received: by 2002:a17:907:6d1c:b0:c12:992b:16d4 with SMTP id a640c23a62f3a-c12992b21c0mr27218366b.41.1782827980269;
        Tue, 30 Jun 2026 06:59:40 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288f4c19esm133015566b.51.2026.06.30.06.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 06:59:39 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Costa Shulyupin
 <costa.shul@redhat.com>, Crystal Wood <crwood@redhat.com>, John Kacur
 <jkacur@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>, Jonathan
 Corbet <corbet@lwn.net>
Subject: Re: [RFC PATCH v2 1/4] rtla/osnoise: Add IPI tracking cmdline option
In-Reply-To: <CAP4=nvRiOdiLA-O8RLBwY+db9__vV+i-Qw3uofOZzjONV+kzYQ@mail.gmail.com>
References: <20260617131803.2988989-1-vschneid@redhat.com>
 <20260617131803.2988989-2-vschneid@redhat.com>
 <CAP4=nvRiOdiLA-O8RLBwY+db9__vV+i-Qw3uofOZzjONV+kzYQ@mail.gmail.com>
Date: Tue, 30 Jun 2026 15:59:36 +0200
Message-ID: <xhsmhpl18w2lz.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4AQJRV3We54ZpL57EjJHKUUu1Z1w0VF93Pc-dX3c00I_1782827981
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29/06/26 12:51, Tomas Glozar wrote:
> st 17. 6. 2026 v 15:18 odes=C3=ADlatel Valentin Schneider
> <vschneid@redhat.com> napsal:
>> @@ -305,6 +305,9 @@ static int opt_filter_cb(const struct option *opt, c=
onst char *arg, int unset)
>>         "the minimum delta to be considered a noise", \
>>         opt_llong_callback)
>>
>> +#define OSNOISE_OPT_IPI OPT_BOOLEAN('i', "ipi", &params->common.ipi, \
>> +       "track sources of IPIs")
>> +
>
> As IPI tracking is not a commonly used functionality, unlike e.g.
> "-p/--period", and -i is already a different option for timerlat tools
> (-i-/--irq), I'd suggest keeping just the long option, --ipi, like I
> did for --on-threshold/--on-end (on Arnaldo's suggestion based on his
> experience from perf [1]). This will make it clear to user the option
> means "IPI detection" and not something else beginning with the letter
> "i". We can always add a short option later if its use becomes common.
>
> [1] https://lore.kernel.org/linux-trace-kernel/aEmWyPqQw2Ly7Jlu@x1/
>

Makes sense to me!

>> [truncated]
>
> Tomas

