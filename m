Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD972E62C8
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Nov 2025 21:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762984622; cv=none; b=PxU2TpOKycDva+SynL++g6ghr9HNhnQXJC6nLWeNCjDpqedFLIcBExnkRD1oUP9POQ8eA4Y/yKNR8VT0aIMd26jQS2+8CaL73Lm1WBMbkojY9mJznNZSqLiwd/MdaZC1H7q14y84iVsn3Ql9xKpb7a/AF7jB/fm0KRGhs9HcYT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762984622; c=relaxed/simple;
	bh=0OTFUF8dKlxaDdn36rkr2KB5xF/wOSqhfWxtBGzWaxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7CTnlVcl6n19Dew4R8UD3ekBrikpldhUC7ii7QHfUWLLbLvSCScnKre8XbPuUg+Nr4RpJV4jeqJjdRRsRywT0VAlWkbzaYcY9sXmEijxxmfEtx3sgN0BH1JGUyF8Caw2Uf+kSBHSUcqx6yVCL3iO4eA/ga//6BIP85MV+IUOP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=YTZQqEPi; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="YTZQqEPi"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-bb7799edea8so94740a12.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1762984620; x=1763589420; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UtzYm6CaQwwng4XDexAXOIVM2T8jYsSpOQI11uV7cIk=;
        b=YTZQqEPiaS/si8bOxnMCFdjnMaTXToGa+627P0ihXde9THCYTRabrnR046dIV/9vpK
         /xGW+/fpk3Ayxcxslmwu8IskYnDVZNHuoz9XgU1oKhwcgEecoUEg0CDvUWsiwQ9QhrD6
         qLzuJ3lhLMCeBg24li73qvZf9qJVTZEH6YQ5QfO7ag9GmeW0S553HICngVx2EtmTy1Zd
         W1TXGld4qghxcGaaLTfm/yqBFdwe9/CMI34rzzA0dL6ygouoq7/eAotojbh3vs493UHc
         P/Yptk1U+JYikQORa3NX0S9xOGe2j4bmELyr8Eqj4URJvRyHBtGASEtlIQxNcDPAl4zc
         Shgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762984620; x=1763589420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UtzYm6CaQwwng4XDexAXOIVM2T8jYsSpOQI11uV7cIk=;
        b=iDD8efusxWohN1DOBLUgwneLsrAzCNRx/xLTU0lw0gmUuElKmM5675Y543FT8jRfRt
         +4G8Cr/yC3dmuch/VL6OxnJqDRLQ94x8kU2B922iEOrINqFt66glsgqMfzLlxjt6/XO1
         NcCFB70Ij3mrSMognFjtvzqPYacAXQ+9vvqySSWsfXzHIlXvNa7q7lRUx9QTVXJ3CNzu
         0Nn1OWsd0K/RkJjV57/8vHOcBGO7EA8IiM7Oz6kU+O2CKVDh7drBNheXPzrkBmbeXD5p
         n5g/8cbuHvaAr7TeO4nZNjdA0VwJswdycDx9s7V6yzGxuCFoBrgCcgdN3Ra09E5NHUa4
         t50Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/R6BU5AjKF1AoIg8y/70CJj3MGL25+9nbULYQpaIBNgVH26iI4Pv3p5LAdNHcXzEcm2e5RWtVlrGWWX/3+5OCAIg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys8M8NrWVchmdpSrhEX/0tAWRY8l7lqdaCEAgn2BQ6731dN2Ky
	/ba1Ah9zzjHyhXMuwEhpVeeRnvo05H67kN2fKrfCyfc5LbJ9uK2AewYM5/JMWClKpsUlqTcO1L4
	W3Yas
X-Gm-Gg: ASbGncuvKsxspiEmQ2DTW/TY8oyujWS40iGnBZwxEf9/V4iZeC+AkoDs+hDNcE/5A5O
	UuCGQz98pxmqUh2fJB1JWqy/Wnhg/3uSnupmHuxzUcOBd35wEKQ7wCYak1WkYbvVLXBh+41eoqG
	NbZJQeemu+e5gYkIIWthPM/8nIy+O1jDO9+6KiIljppFIPMijQJN6kMJKP3SK8j8Ef/Gntj4W3X
	YJb5eBfbRfUF0v5TpGlNzuM3YpnhuXGmA7mQvuCdXSw+F1g8w0b7l7xQPcoDJuhotk5gAtdKBwi
	RljH46TkHV6V/WdFRdp4WZ3kFQ355WccaVRzwE9h0OeLcHvpWwiUbeCsCGGzXtkjmFmoHQDHPYp
	5BQiGTGQ0bl99efpMMm70/8x+ZZXkpEbXMI0LmH6YvfpNvGqCT0ll37JB9jV1pbbXRheBA8FTCq
	F1L/dpngEqt3U+BP07kP9MDspH2OfvNFv4LiBXUDNt4U1Vgx77QBE=
X-Google-Smtp-Source: AGHT+IGGcSgtma54hv+7RKzmUmjycRVqw/LnJDNDCrdXo50noFmBCjb2IbQqtC0Ft6zra7BT9FpOHw==
X-Received: by 2002:a17:902:d4c3:b0:28e:756c:707e with SMTP id d9443c01a7336-2984eda94d4mr56523225ad.33.1762984620190;
        Wed, 12 Nov 2025 13:57:00 -0800 (PST)
Received: from dread.disaster.area (pa49-181-58-136.pa.nsw.optusnet.com.au. [49.181.58.136])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2ccd1fsm1507945ad.110.2025.11.12.13.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 13:56:59 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1vJIpk-00000009zCe-0KVQ;
	Thu, 13 Nov 2025 08:56:56 +1100
Date: Thu, 13 Nov 2025 08:56:56 +1100
From: Dave Chinner <david@fromorbit.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Christian Brauner <brauner@kernel.org>, djwong@kernel.org,
	ritesh.list@gmail.com, john.g.garry@oracle.com, tytso@mit.edu,
	willy@infradead.org, dchinner@redhat.com, hch@lst.de,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, jack@suse.cz, nilay@linux.ibm.com,
	martin.petersen@oracle.com, rostedt@goodmis.org, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/8] xfs: single block atomic writes for buffered IO
Message-ID: <aRUCqA_UpRftbgce@dread.disaster.area>
References: <cover.1762945505.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1762945505.git.ojaswin@linux.ibm.com>

On Wed, Nov 12, 2025 at 04:36:03PM +0530, Ojaswin Mujoo wrote:
> This patch adds support to perform single block RWF_ATOMIC writes for
> iomap xfs buffered IO. This builds upon the inital RFC shared by John
> Garry last year [1]. Most of the details are present in the respective 
> commit messages but I'd mention some of the design points below:

What is the use case for this functionality? i.e. what is the
reason for adding all this complexity?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
