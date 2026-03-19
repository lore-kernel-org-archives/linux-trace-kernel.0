Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C052A3CCFB8
	for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Mar 2026 12:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773921766; cv=none; b=oZFb/sfrZHwzyVZLGyRXi2FcxHVlWoCt+iEIu13U5dx9o94ca6j757i1KBS5wxVPJOGdKTR0itba03ItqrzhAhC5MCTLESpnbjQvLsRJ77/QE4I4Ogswim0bvnugIDX9xMPl89fZ4jroJ0YpHs9RsGBLMy+aUEurCyDOIW03ONQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773921766; c=relaxed/simple;
	bh=HZucGe+tXtLs6arl7n+/zfcUX95wZN5puvhi2kKITJM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DmGG6HdMsyGxtAsSAVdQM+BnZOAUWDuaPnYH0swbFlXS4I3ITuhdfTTb73vtiAOSUJU7O0KTWXLD/1b2RRIeMNuDMT47pB2ybeVGSlNghvla/jToSjcKKMgqKmnBCTuFUieTfjSTXbjNkz1d1bJKSKXI8wJHvi3KQYgwa3fEpLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DftRCptV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DftRCptV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773921763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kmtXuPZqg0u0KuwJyVBzjey4ZPEavJp9+pXBdZV2bRw=;
	b=DftRCptVfsHJVpoVtjowxPdGFz2Mr9CNOfhH4ISGbykKrY5tkQIAXPXsDPN938NsUxegQs
	1qlU6vJPm3EqgNmat+qtUN9MRwl/3j2yA0T5NBbbXKP7q3saVEAYPs6WerdhnrjeMqANX0
	Na5boTX4mh2Le98Zcm22SqqFQhzFX7g=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-k8dTxKMiOCO1-0vwwfZWAA-1; Thu, 19 Mar 2026 08:02:43 -0400
X-MC-Unique: k8dTxKMiOCO1-0vwwfZWAA-1
X-Mimecast-MFC-AGG-ID: k8dTxKMiOCO1-0vwwfZWAA_1773921762
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-89c50acdd4eso17945086d6.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Mar 2026 05:02:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773921762; x=1774526562;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kmtXuPZqg0u0KuwJyVBzjey4ZPEavJp9+pXBdZV2bRw=;
        b=VZoz1jdMsLCWCoxyt9Orrnp/sbxJPU8h66ybB3gtytXJ6BCtSpBiJnwsPXQRVD6PvX
         tx7fwTEQR14NWpctwu+DeABOTPBUESB/ZI0WQjLD7jj9dsCCzXguibZydyumX8YTtx1p
         t/9z/xrOlnDtpwQm1EiCTohhHstch5melj8CJMkSzidrnZnW13wQgUa9GrTM+Q9pyBoP
         EQAdGF2knp+sr4vegQJ494HTIcDqk1JgO/MTtueBw4AMQPp2f6I9m0Lhuj6Nh6eGps9N
         DEMKlPPoHxY4Da8UljQB9OBDGKmoW6CwUzIiXPBkESnWzDu9pBW6YIU1acNmonxy+dv+
         H5zQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiZXSfNRioBJagEiG3DsyGmG3AhqiFLKKVzTYeTjnOJX56vnGeV6fvLO1PTj210Fjt54pvB0tziMa/79P0DQufcwA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr618x2MeZlAmOuJ1nYduUMvfUkj1nKpwxoP4fSOSgmHmgyMot
	DGwdQMIpNzmPKwCHRf+Rgvur0fvHLF46dncPKLRffRSFlWzUwKEPvEfmiIXcLmW7I0VyWBnXSdY
	GfUqHle1Fd0BWWVAPD+mCCfOu5dkMvSBHoADzG3OFbZcNIIGXDuLHmoddU4CK0RJ/GUV+EhtkkA
	==
X-Gm-Gg: ATEYQzy7oXMsCBqL1NAqKsQWp4sZoJeto0RIm1Ke4k8i27SIqBCyj9iKN+OzUOvdodE
	4X77LPt3vaAL3p4r/N+e/7qXq3FVsC/lMDgRzefZgiwWUWuGD0QQvoPz63a4C1oRSKPa3bR1g8G
	kj0bIrdnU4ewoFb8IZJyqtvHpcAkyZIr0MZKyMpCngAPnzZWZ0ovIjqaouUSs6gv2OCBsb8UD5i
	joRY7eIyqyNijEOxyxQNy95DNx3ftZWk9PRzMZe1dCTzO+erxVEpIZA8vMInpgwtcwOIK9wqolO
	sEmoC5h0HnL7ykn9ZAj4ZYDPcIEZthwhXlbYMty1V3To8z236SwQELzUhDOx4sy9xvlKNtpJBNO
	qOM5c0rg9SBb7B2xP3pOyTrDpBfRfOC2NI9cmDxAew1nWFk8lCAAbOpZNKno=
X-Received: by 2002:ad4:5ded:0:b0:89a:666:ad2b with SMTP id 6a1803df08f44-89c6b56bcf5mr102005126d6.27.1773921762304;
        Thu, 19 Mar 2026 05:02:42 -0700 (PDT)
X-Received: by 2002:ad4:5ded:0:b0:89a:666:ad2b with SMTP id 6a1803df08f44-89c6b56bcf5mr102002236d6.27.1773921759463;
        Thu, 19 Mar 2026 05:02:39 -0700 (PDT)
Received: from loberman-thinkpadp16gen3.rmtusma.csb ([2600:6c64:4e7f:603b:aa2b:ddff:fe88:da74])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c6b8e0a5bsm43875346d6.6.2026.03.19.05.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 05:02:38 -0700 (PDT)
Message-ID: <9d6ca1c6c919de0999c64628feabf1e677f7e759.camel@redhat.com>
Subject: Re: [PATCH v2] blk-mq: add tracepoint block_rq_tag_wait
From: Laurence Oberman <loberman@redhat.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Aaron Tomlin
	 <atomlin@atomlin.com>, "axboe@kernel.dk" <axboe@kernel.dk>, 
 "rostedt@goodmis.org"
	 <rostedt@goodmis.org>, "mhiramat@kernel.org" <mhiramat@kernel.org>, 
 "mathieu.desnoyers@efficios.com"
	 <mathieu.desnoyers@efficios.com>
Cc: "kch@nvidia.com" <kch@nvidia.com>, "bvanassche@acm.org"
 <bvanassche@acm.org>,  "dlemoal@kernel.org"	 <dlemoal@kernel.org>,
 "ritesh.list@gmail.com" <ritesh.list@gmail.com>,  "neelx@suse.com"	
 <neelx@suse.com>, "sean@ashe.io" <sean@ashe.io>, "mproche@gmail.com"	
 <mproche@gmail.com>, "chjohnst@gmail.com" <chjohnst@gmail.com>, 
 "linux-block@vger.kernel.org"	 <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org"	 <linux-kernel@vger.kernel.org>,
 "linux-trace-kernel@vger.kernel.org"	 <linux-trace-kernel@vger.kernel.org>
Date: Thu, 19 Mar 2026 08:02:36 -0400
In-Reply-To: <63dfc26d-7d9d-4530-bf85-4f07fbcf240a@wdc.com>
References: <20260319015300.287653-1-atomlin@atomlin.com>
	 <63dfc26d-7d9d-4530-bf85-4f07fbcf240a@wdc.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Mxeor3v2uvRA15OAPR5OZFsozBWNN8MafW8VAgUMI3o_1773921762
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-03-19 at 07:32 +0000, Johannes Thumshirn wrote:
> Looks good,
>=20
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Looks good now.

Reviewed-by: Laurence Oberman <loberman@redhat.com>
Tested-by:   Laurence Oberman <loberman@redhat.com>

