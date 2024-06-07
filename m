Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2C179F4;
	Fri,  7 Jun 2024 19:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717789109; cv=none; b=RpRUjCmy0NFiOAYzjNEVcY4myEWtAdMSEbdbjpbhvA1upQ/78n3obZbbhTwvTL75+tq9/WuoMVUnZtUDIM0fNjhZyyCERVK2iojhR4MWc4aKWyXM8F8HRdooxAbNodvB+AHb1ZJ/ugfKIXQ/Iq7AyMSncQRbKVKfW1Fl6X5eSZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717789109; c=relaxed/simple;
	bh=KoQW0PfrjsXYERprsNLLYE9VORE3VUwWvRgrI4DMz7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ks3VvaVzgrYZQ8VNXDmnvnH/NvsQVvDiGi9m6WXchhUVRL9mlvzyaDwTn/Eig3dzGXjcs5E8GS758bqKNcuNfIKltI9EQXYhKUHBooHvQFLVrZG26y/n3UVqyYwFPJ1PAXu7Q7yWTo6iR9D0gMx9HLyJylPYpmIGYHxihACtBhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Ix7UY4kd; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Ix7UY4kd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MTEzRWAwJ8LSeiEucNCTCesadgMsTVrZqtI4H5H8Hj0=; b=Ix7UY4kdZPsy4Alki1oHK0Wmbg
	zmyUnbpdgvF1WCQyOyB6+q/D8Zkr65aLzU97FOb7x+c2i7fxy7r5qKYlw0hG1QWk6fX82yx1uzj/2
	0jWgn5GnwbY6LypKEs5c9g2/bx2htbFCY5xU4+niILa9jWdjXXOv/A3g3v3HWFRC8CW8CIVDDd8s5
	VBG2odFDNPhLgeGHLoyxYQjwEVbBmvGEyVocDAAGLwEq0jiCDgfi8tj66tarvEI9D7JJUQSZ5y8no
	VNsoXvgLLTeUwHIUw3OpLbzZcGOEmmFHbrEqKyqL3n+KUTfmo7r77YkNZs14f7A8zUiZNEC/panes
	Vs3tz7dQ==;
Received: from [191.205.188.103] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1sFfPk-000e9A-VB; Fri, 07 Jun 2024 21:38:17 +0200
Message-ID: <cd1b2a9a-6f0d-65c0-4a0e-a525ed2487d9@igalia.com>
Date: Fri, 7 Jun 2024 16:38:06 -0300
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/2] pstore/ramoops: Add ramoops.mem_name= command line
 option
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 linux-trace-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
 Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, Kees Cook <keescook@chromium.org>,
 Tony Luck <tony.luck@intel.com>, linux-hardening@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>, Ross Zwisler <zwisler@google.com>,
 wklin@google.com, Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Suleiman Souhlal <suleiman@google.com>,
 Linus Torvalds <torvalds@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
References: <20240606150143.876469296@goodmis.org>
 <20240606150316.916395285@goodmis.org>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20240606150316.916395285@goodmis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Steve, thanks for the patch! A suggestion/fix below, inline.


On 06/06/2024 12:01, Steven Rostedt wrote:
> [...]
> +static char *mem_name;
> +module_param_named(mem_name, mem_name, charp, 0400);
> +MODULE_PARM_DESC(mem_name,
> +		"name of kernel param that holds addr (builtin only)");

s/ (builtin only)//

Likely a vestige of a previous version heh
Cheers,

Guilherme
