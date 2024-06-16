Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A8C2E403;
	Sun, 16 Jun 2024 01:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718501018; cv=none; b=R6AQOXzGn/klPC9jx8nQB011QV/oxdAnRhazfUNpOSA0iXjvFOXZ7Z1470l35rahba/0ndqBEY7s/G1tDpxAdzhfp6m2N4sPkcY2uXntDHeyt+PvVBjHKLARcSglWMgSMarwxtujF4FsM9lin7m02aIezp/8cuvLcyPNs1lEwGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718501018; c=relaxed/simple;
	bh=ro9Ubtf2VbL1tovMUy5Bxa4PT3UX7Kpu8c/NtRLKO4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuHzln82alCMmMP66VQl2V3rJHUf+Wsmhq4jdlS0UjL391WkuEHZGMMoNqOsMLKYOUnETOzR4qR5rG35HD6GTK2YR+tKPBc+K2P2IbjUv+XM8yJx9S/gNzEsc1QF4rBCFJgibzeR+qumopFB1u/l+ANjFBcEFpmtMr3KW/VDJcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rjr5Oh8u; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rjr5Oh8u"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57c6994e2f1so1824633a12.0;
        Sat, 15 Jun 2024 18:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718501015; x=1719105815; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9L818WkrX/e57/2+JLNhNwDE+80PZ6UZB0TCqcvAH0=;
        b=Rjr5Oh8u8OsHNiub0naUvzYmP+ldVpm8WJ0S/wwRRPAKMO4gfk7SnJc5JPnNEU2h8m
         7Tmm+pTyPQ0c2DCnggmR3bAzuQM8h9FZXwC4xiFH6rF12cGN2sxhBHkLMogMyChDuYh0
         LO9p98aG6XGMOStKChdsA9SqZOqUujRiQkLb14ct8ScxGHaIzylc4z5bzq/g4agCfwht
         lrwDgYfD4bqoqxzBkEn70xloKvTQ4ZWM9SCE/JRk1KG1x8EhAr9ktggKHEZNV2PS+Daf
         IlBfo5JCTM1FxU530qb4akF5xdbef0ApIb/vytePNW4dfiS7O7qTKWfzzZwDi4UK9rGm
         /EaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718501015; x=1719105815;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J9L818WkrX/e57/2+JLNhNwDE+80PZ6UZB0TCqcvAH0=;
        b=PlsoPZ3NTOrAd1zB6jtSid9m24w07CxVdbYzJiNHBydsIX+YRdSW14EUub5FxgT98V
         /mK4T4HCJezirtYVKT+xJRMKS5Bx/GgCGO4aDAuOoseXQm8pa9TesZ8hb1K4N6qfnUog
         J9pLX3cbmpC4R+i8U0gg+uFrSMJ9whVqvfCMxfNkxLMeBrgGrLxeZKG3iDtmU8Ee46Iz
         vkqkzSOfvLvjM5KvtrY6wZViTmi4eJcansocFL5R7o7VFrfS/GfE1WLHECMYhfwahdYO
         +a+LP2nO8fRBdublffXmJRl57o6/VyPmfnX1J3u4PlUiiWXNp7kjTZ1wpve6JVxd4eas
         khWg==
X-Forwarded-Encrypted: i=1; AJvYcCXf3O2CjW5tYHmpRWV4BFHgcYuJDvn4ZvQhjcXDMIohUXCkKoFn8RspNi7aJvTbfe0rNT7Azx4NcFFl07fIeCqfbW39xQTOkOalSEjUmilwzE/7b8g8ajgIHxb7x//kNA4i3BWo7oeZO33ZakAZol6VD3rf
X-Gm-Message-State: AOJu0Yyj/eFPjOvlIXXdI89LggRHNDPZImWW6w/srCY/tf/84z6bh378
	1P6/orbEeDScbK/lhY4m97tmMqpisMZpx+PcSKPE93NJLK39pE3x
X-Google-Smtp-Source: AGHT+IFtCyjk6B2n0WL5jZjzknr32ZUP22JOAasG1n2zIMpqR6Bmv50VyYRbU7uqiXLlR1DQ2YBJjw==
X-Received: by 2002:a50:c30b:0:b0:579:d673:4e67 with SMTP id 4fb4d7f45d1cf-57cbd6c7495mr5098355a12.26.1718501014766;
        Sat, 15 Jun 2024 18:23:34 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb741e725sm4305462a12.69.2024.06.15.18.23.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Jun 2024 18:23:34 -0700 (PDT)
Date: Sun, 16 Jun 2024 01:23:33 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-hardening@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	Ross Zwisler <zwisler@google.com>, wklin@google.com,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v5 0/2] mm/memblock: Add "reserve_mem" to reserved named
 memory at boot up
Message-ID: <20240616012333.c6ddobbv6aq4jlyn@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240613003435.401549779@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613003435.401549779@goodmis.org>
User-Agent: NeoMutt/20170113 (1.7.2)

Hi, Steven 

Would you mind cc me in the following version?


-- 
Wei Yang
Help you, Help me
